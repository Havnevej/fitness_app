package group_six.drone_controller;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.*;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontPosture;
import javafx.stage.Stage;

import java.io.IOException;


public class Main extends Application {
    private static int speed = 0;
    final static Image player = new Image("file:drone.png");
    static ImageView drone_player;
    public static void main(String[] args) { launch(args) ;}
    private static int drone_window_height = 475;
    private static int drone_window_width = 600;

    @Override public void start(Stage stage) throws IOException {
        drone_player = new ImageView(player);
        drone_player.setFitHeight(50);
        drone_player.setFitWidth(50);
        final Group group = new Group(createInstructions(), drone_player);
        final Scene scene = new Scene(group, 600, 500, Color.DARKTURQUOISE);

        stage.setScene(scene);
        stage.show();

        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        Stage secondStage = new Stage();
        secondStage.setScene(new Scene(root, drone_window_width, drone_window_height));
        secondStage.show();
    }

    static Label createInstructions() {
        Label instructions = new Label(
                "move the drone by using the joystick");
        instructions.setTextFill(Color.AZURE);
        instructions.setFont(Font.font("Verdana", FontPosture.ITALIC, 20));
        instructions.setLayoutX((drone_window_width/4));
        return instructions;
    }

    public static void move_drone(String MESSAGE){
        System.out.println(MESSAGE);
        if(MESSAGE.equals("initialize")){
            drone_player.setY(drone_window_height/2);
            drone_player.setX(drone_window_width/2);
        }
        if (MESSAGE.equals("moveup")) {
            if (get_drone_center_y() + drone_player.getFitHeight()/2 - get_speed_of_drone() > 0) {
                drone_player.setY(drone_player.getY() - get_speed_of_drone());
            } else {
                drone_player.setY(drone_window_height-drone_player.getFitHeight());
            }
        }
        if(MESSAGE.equals("movedown")){
            if (!((drone_player.getY() - drone_player.getFitWidth()/2 + get_speed_of_drone()) > drone_window_height)) {
                drone_player.setY(drone_player.getY() + get_speed_of_drone());
            } else {
                drone_player.setY(0);
            }
        }
        if(MESSAGE.equals("moveleft")){
            if ((get_drone_center_x() - drone_player.getFitWidth()/2 - get_speed_of_drone()) > 0.0) {
                drone_player.setX(drone_player.getX() - get_speed_of_drone());
            }else {
                drone_player.setX(drone_window_width-drone_player.getFitWidth());
            }
        }
        if(MESSAGE.equals("moveright")){
            if (!((drone_player.getX() - drone_player.getFitWidth()/2 + get_speed_of_drone()) > drone_window_width)) {
                drone_player.setX(drone_player.getX() + get_speed_of_drone());
            }else{
                drone_player.setX(0);
            }
        }
    }

    //GETTERS AND SETTERS
    static void set_speed_of_drone(String speed){
        Main.speed = Integer.parseInt(speed);
    }

    static int get_speed_of_drone() {
        return Main.speed;
    }
    static int get_drone_window_height() {
        return drone_window_height;
    }
    static int get_drone_window_width() {
        return drone_window_width;
    }
    private static double get_drone_center_x(){
        return drone_player.getX() + drone_player.getFitWidth()/2;
    }
    private static double get_drone_center_y(){
        return drone_player.getY() + drone_player.getFitHeight()/2;
    }
}