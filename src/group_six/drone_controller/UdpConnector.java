package group_six.drone_controller;

import java.io.IOException;
import java.net.*;

public class UdpConnector implements Runnable{
    private DatagramSocket socket;
    private final int udp_listen_port = 7000;
    private final int udp_send_port = 7009;
    private boolean serverRun = true;
    private Controller message_handler;

    UdpConnector(Controller message_handler)
    {
        this.message_handler = message_handler;
        setupSocket();
    }

    void close_socket()
    {
        this.socket.close();
    }

    private void setupSocket() {
        try {
            socket = new DatagramSocket(udp_listen_port);
        } catch (SocketException e) {
            System.out.println("IOEXCEPTION: Tried to create new datagramsocket on "+ udp_listen_port);
            System.out.println(e.getMessage());
        }
    }

    private void sendOK(InetAddress address)
    {
        byte[] send = "ok".getBytes();
        DatagramPacket packet = new DatagramPacket(send, send.length, address, udp_send_port);
        try {
            socket.send(packet);
        } catch (IOException e) {
            System.out.println("IOEXCEPTION: Tried to send packet");
        }
    }

    private UdpMessage receive_message() {
        byte[] buf = new byte[256];
        DatagramPacket packet = new DatagramPacket(buf, buf.length);
        try {
            socket.receive(packet); // actually receiving the message here
            UdpMessage message = new UdpMessage(packet.getData(), packet.getLength(), packet.getAddress() , packet.getPort());

            if(message.getLength() <=2){ // If the length of the message is less than or equal to two, we know the message is a number which will change the speed
                Main.set_speed_of_drone(message.getMessage());
            } else {
                Main.move_drone(message.getMessage());
            }
            message_handler.receiveMessage(message);
            return message;
        } catch (IOException e) {
            System.out.println("IOEXCEPTION: Tried to receive packet");
            return null;
        }
    }

    private void udp_monitor()
    {
        try {
            UdpMessage message = receive_message();
            if(message != null) {
                sendOK(InetAddress.getByName(message.getIp())); // we send ok back if message is not null
            }
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        connection_main_loop();
    }

    private void connection_main_loop() {
        System.out.println("Started UDP Monitor");
        while (serverRun){
            udp_monitor();
        }
    }
}
