package group_six.drone_controller;

import javafx.fxml.FXML;
import javafx.scene.control.Control;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;

public class Controller {
    @FXML
    TableView<UdpMessage> table;

    private UdpConnector udpConnector;
    public void initialize()
    {
        System.out.println("initializing UDP monitor");
        startUdpConnection();
    }

    private void startUdpConnection() {
        if (udpConnector != null) udpConnector.close_socket();
        udpConnector = new UdpConnector(this);
        new Thread(udpConnector).start();
    }

    void receiveMessage(UdpMessage udpMessage)
    {
        table.getItems().add(0, udpMessage);
    }
}