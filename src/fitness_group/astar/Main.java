package fitness_group.astar;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.HBox;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class Main extends Application {
    /*
        ###########  Values #########
     */
    private static final int window_width = 1080;
    private static final int window_height = 720;
    static boolean is_painting = true;
    static boolean setting_start = false;
    static boolean setting_end = false;
    static AnchorPane root;
    private static fitness_group.astar.Grid_Handler grid_handler;
    private static Text text_info;
    private static HBox hi,hi3,hb,hb2,speed,Manhattan,Euclidean;
    private static Button button_generate = new Button("Generate");
    private static Button button_solve = new Button("Solve");

    private static Button button2_setstart = new Button("Set start");
    private static Button button2_setend = new Button("Set end");

    private static Text status_text;

    private static CheckBox checkBox_manhattan;
    private static CheckBox checkBox_euclidean;

    private static UI_Handler ui = new UI_Handler();
    /*
        ###########  /Values #########
     */

    @Override
    public void start(Stage stage) {
        root = new AnchorPane();
        Scene scene = new Scene(root,window_width,window_height);
        stage.setScene(scene);
        scene.setRoot(root);
        grid_handler = new Grid_Handler();

        checkBox_manhattan = new CheckBox("Manhattan");
        checkBox_manhattan.selectedProperty().set(true);
        Manhattan = new HBox(checkBox_manhattan);

        checkBox_euclidean = new CheckBox("Euclidean");
        Euclidean = new HBox(checkBox_euclidean);
        root.getChildren().addAll(Euclidean, Manhattan);


        ui.setup_ui();
        ui.setup_listeners();
        stage.show();
    }
    public static void main(String[] args) {
        launch(args); //javaFX init
    }

    static Grid_Handler getGrid_handler() { return grid_handler; }
    static UI_Handler getUi() { return ui; }

    static class UI_Handler { //inner ui class that is static so it can be referenced everywhere to update the ui
        void set_status_text(String text){ //updates the text below the main frame
            Main.root.getChildren().remove(status_text);
            setup_ui();
            status_text.setText(text);
        }
        void setup_listeners(){ //sets up the required UI listeners for when users click buttons or change the checkboxes
            button_generate.setOnAction(event -> { // when user clicks the generate button
                try {
                    TextField widthsize_field = (TextField) hi.getChildren().get(1);
                    TextField heightsize_field = (TextField) hi3.getChildren().get(1);

                    int size_width = Integer.parseInt(widthsize_field.getText());
                    int size_height = Integer.parseInt(heightsize_field.getText());

                        if(size_width*grid_handler.getBox_width() <= window_width && size_height*grid_handler.getBox_height() <= window_height) {
                            grid_handler.generate_grid(size_width,size_height, true);
                            set_status_text("Generated new layout");
                        } else {
                            System.out.println("Input too big for the window");
                        }
                    } catch (NumberFormatException e){
                    System.out.println("Input can only be integers");
                }
            });
            button_solve.setOnAction(event -> { //when user clicks button.solve
                TextField speed_field = (TextField) speed.getChildren().get(1);
                A_Star.setAnimation_speed(Integer.parseInt(speed_field.getText()));

                new A_Star(grid_handler);
                set_status_text("solving");
            });
            button2_setstart.setOnAction(event -> { //when user clicks set start
                setting_start = true;
                set_status_text("Setting start location");
            });
            button2_setend.setOnAction(event -> { //when user clicks set end
                setting_end = true;
                set_status_text("Setting end location");
            });
            checkBox_euclidean.selectedProperty().addListener((observableValue, aBoolean, t1) -> { // when user checks the checkbox
                if(checkBox_euclidean.selectedProperty().get()){
                    A_Star.setIs_manhattan(false);
                    checkBox_manhattan.selectedProperty().set(false);
                } else {
                    A_Star.setIs_manhattan(true);
                    checkBox_manhattan.selectedProperty().set(true);
                }
            });
            checkBox_manhattan.selectedProperty().addListener((observableValue, aBoolean, t1) -> { // when user checks the checkbox
                if(checkBox_manhattan.selectedProperty().get()){
                    if(!A_Star.getIs_manhattan()){
                        A_Star.setIs_manhattan(true);
                        checkBox_euclidean.selectedProperty().set(false);
                    }
                } else {
                    A_Star.setIs_manhattan(false);
                    checkBox_euclidean.selectedProperty().set(true);
                }
            });
        }
        void setup_ui(){ // This functions sets up the ui according to hardcoded coordinates and values, it is not flexible
            Label label1 = new Label("Width Size:"); //Changed from Grid Size to Width Size
            Label label3 = new Label("Height size:");
            Label label_speed = new Label("Solving speed (ms):");

            TextField textField = new TextField();
            TextField textField2 = new TextField();
            TextField textField3 = new TextField();
            TextField textField_speed = new TextField();

            textField.setText(String.valueOf(grid_handler.getCurrent_size_width()));
            textField3.setText(String.valueOf(grid_handler.getCurrent_size_height()));
            textField2.setText(String.valueOf(grid_handler.getBlockers()));
            textField_speed.setText(String.valueOf(A_Star.getAnimation_speed()));

            hi = new HBox();
            hi.getChildren().addAll(label1, textField);
            hi.setSpacing(10);

            hi3 = new HBox();
            hi3.getChildren().addAll(label3, textField3);
            hi3.setSpacing(10);

            speed = new HBox();
            speed.getChildren().addAll(label_speed, textField_speed);
            speed.setSpacing(10);

            hb = new HBox();
            hb.getChildren().addAll(button_generate, button_solve); //more buttons
            hb.setSpacing(25);
            hb.setMinWidth(150);

            hb2 = new HBox();
            hb2.getChildren().addAll(button2_setstart, button2_setend); //more buttons
            hb2.setSpacing(25);
            hb2.setMinWidth(150);

            status_text = new Text();
            status_text.setText("");

            text_info = new Text();
            text_info.setText("To add blocks click and drag 'leftclick' and to remove blocks click and drag 'rightclick' ");

            Manhattan = new HBox(checkBox_manhattan);
            Euclidean = new HBox(checkBox_euclidean);

            root.getChildren().addAll(hi, hi3, hb, hb2, Manhattan, Euclidean, status_text, speed, text_info);

            hi.relocate(window_width-300,150); //width
            hi3.relocate(window_width-300,180); //Height
            speed.relocate(window_width-340,210); //Solving speed

            Manhattan.relocate(window_width-300,300);
            Euclidean.relocate(window_width-300,330);

            text_info.relocate(window_width-900,600);
            status_text.relocate(window_width/2, window_height-window_width/6);

            hb.relocate(window_width-250,15);
            hb2.relocate(window_width-250,hb.getLayoutY()+25);
        }
    }
}
