package fitness_group.astar;

import javafx.event.EventHandler;
import javafx.scene.input.MouseDragEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import java.util.ArrayList;

class Node{
    private final int MOVEMENT_COST = 10; //constant for the movement cost 10 is normal to use
    int g_value;
    int h_value;
    Tile previous = null;

    Node() { }
    // sets the gvalue (updated throughout)
    void setG_value(int amount) {
        this.g_value = amount;
    }
    //heuristic function that takes from and to Tiles
    int calculate_h_value(Tile from, Tile destPoint) {
        if (A_Star.getIs_manhattan()) {
            this.h_value = (Math.abs(destPoint.x - from.x) + Math.abs(destPoint.y - from.y)) * MOVEMENT_COST;      //Manhattan
        } else {
            double double_h = Math.sqrt(Math.pow((destPoint.x - from.x), 2) + Math.pow((destPoint.y - from.y), 2)) * MOVEMENT_COST;
            this.h_value = (int) double_h;
            //this.h_value = (int) Math.sqrt(Math.pow(destPoint.x - from.x, 2) + Math.pow(destPoint.y - from.y, 2) * MOVEMENT_COST); // Euclidean
        }
        return this.h_value;
    }
    // function for getting the fvalue of this node (gets updated throughout the algorithm)
    int getF_value() {
        return this.g_value + this.h_value;
    }
}
class Tile extends Node { //extends Node (which is a* related functions)
    int x, y;
    int id;
    int pos_x, pos_y;
    private int width, height;
    boolean blocking = false;
    private Color color1 = Color.GREEN;
    private Color color2 = Color.DARKGREY;
    private Rectangle my_rect;
    ArrayList<Tile> adjacent_nodes = new ArrayList<>();
    private boolean is_end;
    private boolean is_start;

    Tile(int pos_x, int pos_y,int x, int y, int width, int height, int id) {
        this.id = id;
        this.pos_x = pos_x;
        this.pos_y  = pos_y;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        update_tile();
    }

    public int getX() { return x; }
    public int getY() { return y; }

    // Functions for displaying the tiles
    void update_tile() {
        my_rect = new Rectangle(pos_x, pos_y, width, height);
        my_rect.setStroke(color1);
        my_rect.setFill(color2);
        my_rect.addEventFilter(MouseDragEvent.DRAG_DETECTED, e -> {
            my_rect.startFullDrag();
            Main.is_painting = true;
        });
        my_rect.addEventFilter(MouseDragEvent.MOUSE_DRAG_ENTERED, e -> {
            if(e.isSecondaryButtonDown()){
                clear_blocking();
            } else {
                if(Main.is_painting){
                    System.out.println("Set blocker");
                    set_blocking();
                }
            }
        });
        my_rect.addEventFilter(MouseDragEvent.MOUSE_DRAG_RELEASED, e -> {
            Main.is_painting = false;
        });
        my_rect.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {
                if(Main.setting_start) {
                    Main.getGrid_handler().getTiles().get(Main.getGrid_handler().getStart_tile()).clear_start();
                    Main.getGrid_handler().generate_start(Main.getGrid_handler().getTiles(),id);
                    Main.setting_start = false;
                } else if (Main.setting_end){
                    Main.getGrid_handler().getTiles().get(Main.getGrid_handler().getEnd_tile()).clear_end();
                    Main.getGrid_handler().generate_end(Main.getGrid_handler().getTiles(),id);
                    Main.setting_end = false;
                }
            }
        });
        Main.root.getChildren().add(my_rect);
    }

    public void set_blocking() {
        this.blocking = true;
        color1 = Color.DARKRED;
        color2 = Color.RED;
        update_tile();
    }

    public void clear_blocking(){
        this.blocking = false;
        color1 = Color.GREEN;
        color2 = Color.DARKGREY;
        update_tile();
    }

    void set_custom_color(Color color){
        this.color1 = color;
        this.color2 = color;
        update_tile();
    }

    public void set_custom_color(Color color, Color color2){
        this.color1 = color;
        this.color2 = color2;
        update_tile();
    }

    void setIs_end() {
        this.is_end = true;
        color1 = Color.YELLOW;
        color2 = Color.LIGHTGOLDENRODYELLOW;
        update_tile();
    }
    void setIs_start() {
        this.is_start = true;
        color1 = Color.DARKGREEN;
        color2 = Color.GREEN;
        update_tile();
    }
    private void clear_start(){
        this.is_start = false;
        color1 = Color.GREEN;
        color2 = Color.DARKGREY;
        update_tile();
    }
    private void clear_end(){
        this.is_end = false;
        color1 = Color.GREEN;
        color2 = Color.DARKGREY;
        update_tile();
    }
}
