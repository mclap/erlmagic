#include "erl_interface.h"
#include "ei.h"
#define SELF(fd) erl_mk_pid(erl_thisnodename(),fd,0,erl_thiscreation())

#define PORT 7001
#define BUFSIZE 10000

#include <Magick++.h>
#include <iostream>
#include <string>
#include <list>
#include <vector>

using namespace std;
using namespace Magick;

#include "composite_def.cpp"

int my_listen(int port) {
  int listen_fd;
  struct sockaddr_in addr;
  int on = 1;

  if ((listen_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    return (-1);

  setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));

  memset((void*) &addr, 0, (size_t) sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  addr.sin_addr.s_addr = htonl(INADDR_ANY);

  if (bind(listen_fd, (struct sockaddr*) &addr, sizeof(addr)) < 0)
    return (-1);

  listen(listen_fd, 5);
  return listen_fd;
}

map <int, Image> image_map;
int last_image = 0;

Image &get_image(int param_num, ETERM* msg) 
{
  last_image = ERL_INT_VALUE(erl_element(param_num, msg));
  return image_map[last_image];
}

void del_image(int param_num, ETERM* msg)
{
  int idx = ERL_INT_VALUE(erl_element(param_num, msg));
  map<int, Image>::iterator it = image_map.find(idx); 
  image_map.erase(it);
}

vector<Image> getImageVector(int param_num, ETERM* msg)
{
  vector<Image> rval;
  ETERM *list = erl_element(param_num, msg);
  if (!ERL_IS_LIST(list)) {
    cout << "list is not a list" << endl;
  }
  for (ETERM *hd = erl_hd(list); hd != NULL; hd = erl_hd(list)) {
    int idx = ERL_INT_VALUE(hd);
    Image& image = image_map[idx];
    rval.push_back(image);
    list = erl_tl(list);
  }
  return rval;
}

int main(int argc,char **argv)
{
  int sockfd;

  ErlConnect erlc;
  int fd;
  int identification_number = 1;
  int creation=1;
  char *cookie="cookie"; /* An example */

  try {
    erl_init(NULL, 0);

    if (erl_connect_init(identification_number, cookie, creation) == -1)
      erl_err_quit("erl_connect_init");

    //fprintf(stderr, "connected\n");
    if ((sockfd = my_listen(PORT)) <= 0)
      erl_err_quit("error: my_listen");

    // fprintf(stderr, "listening\n");

    if ( erl_publish(PORT) == -1)
      erl_err_quit("error: publish");

    // fprintf(stderr, "published\n");

    if ((fd = erl_accept(sockfd, &erlc)) == ERL_ERROR)
      erl_err_quit("erl_accept");

    fprintf(stderr, "accepting on fd %i\n", fd);
    int image_index = 0;

    ETERM *ok = erl_mk_atom("ok");
    bool exit = false;

    while(!exit) {
      unsigned char buf[BUFSIZE];
      ErlMessage emsg;
      int rec = erl_receive_msg(fd, buf, BUFSIZE, &emsg);
      if (rec == ERL_MSG)
	//cout << "get message" << endl;
	;
      else if (rec == ERL_TICK) {
	//cout << "tick received" << endl;
	continue;
      }
      else if (rec == ERL_ERROR)
	//cout << "msg error " << errno << endl;
	;
      

      ETERM *pid = erl_element(1, emsg.msg);
      ETERM *msg = erl_element(2, emsg.msg);
      if (ERL_IS_TUPLE(msg)) {
	string command((const char*)ERL_ATOM_PTR(erl_element(1, msg)));
	if (command == "read") {
	  string file((const char*) erl_iolist_to_string(erl_element(2, msg)));
	  Image image;
	  image.read(file);
	  image_map[image_index] = image;
	  ETERM *reply = erl_mk_int(image_index++);
	  erl_send(fd, pid, reply);
	}
	else if (command == "write") {
	  Image& image = get_image(2, msg);
	  string file((const char*) erl_iolist_to_string(erl_element(3, msg)));
	  image.write(file);
	  erl_send(fd, pid, ok);
	}
	else if (command == "montageImages") {
	  vector<Image> imageList = getImageVector(2, msg);
	  string file((const char*) erl_iolist_to_string(erl_element(3, msg)));
	  vector<Image> montage;
	  MontageFramed montageOpts;
	  montageImages( &montage, imageList.begin(), imageList.end(), montageOpts );
	  writeImages(montage.begin(), montage.end(), file);
	  erl_send(fd, pid, ok);
	}
	else if (command == "clone") {
	  Image& image = get_image(2, msg);
	  Image clone = image;
	  image_map[image_index] = clone;
	  ETERM *reply = erl_mk_int(image_index++);
	  erl_send(fd, pid, reply);
	  
	}
	else if (command == "delete") {
	  del_image(2, msg);
	  erl_send(fd, pid, ok);
	}

#include "im_commands.h"
	if (command == "quit") {
	  exit = true;
	  erl_send(fd, pid, ok); 
	}
	else {

	}
      }
    }
  }
  catch( Exception &error_ ) {
      cout << "Caught exception: " << error_.what() << endl;
      return 1;
  }
  return 0;
}

