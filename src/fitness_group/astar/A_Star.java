package fitness_group.astar;


import javafx.animation.Animation;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.util.Duration;

import java.util.ArrayList;


public class A_Star {
    private static int animation_speed = 100;
    private static boolean is_manhattan = true;
    private static Tile end_node;
    private static Tile current;
    private ArrayList<Tile> open_list;
    private ArrayList<Tile> closed_list;
    private ArrayList<Tile> best_path;
    private ArrayList<Tile> nodes = new ArrayList<>();

    private Timeline tl = new Timeline();
    private Grid_Handler grid_handler;

    A_Star( Grid_Handler grid_handler) {
        this.grid_handler = grid_handler;
        nodes.addAll(grid_handler.getTiles());

        System.out.println(nodes.size());
        set_neighbours();

        open_list = new ArrayList<>();
        closed_list = new ArrayList<>();
        best_path = new ArrayList<>();


        current = nodes.get(grid_handler.getStart_tile());
        current.setG_value(0);
        open_list.add(current);
        end_node = nodes.get(grid_handler.getEnd_tile());

        tl.setCycleCount(Animation.INDEFINITE);
        tl.getKeyFrames().add(animateA_star);
        tl.play();
    }

    static int getAnimation_speed() { return animation_speed; }
    static void setAnimation_speed(int animation_speed) { A_Star.animation_speed = animation_speed; }

    static boolean getIs_manhattan() { return is_manhattan; }
    static void setIs_manhattan(boolean is_manhattan) { A_Star.is_manhattan = is_manhattan; }


    private void draw_best_path(ArrayList<Tile> path){
        for (Tile n : path){
            grid_handler.getTiles().get(n.id).set_custom_color(Color.WHEAT);
        }
    }
    private void draw_open_set(ArrayList<Tile> path){
        for(Tile n : path){
            grid_handler.getTiles().get(n.id).set_custom_color(Color.DARKGREEN);
            Main.root.getChildren().add(new Text(
                    grid_handler.getTiles().get(n.id).x*grid_handler.getBox_width(),
                    grid_handler.getTiles().get(n.id).y*grid_handler.getBox_height()+(grid_handler.getBox_height()/2),
                    String.valueOf(n.getF_value())));
        }
    }
    private void draw_closed_set(ArrayList<Tile> path){
        for(Tile n : path){
            grid_handler.getTiles().get(n.id).set_custom_color(Color.DARKKHAKI);
        }
    }

    private KeyFrame animateA_star = new KeyFrame(Duration.millis(animation_speed), new EventHandler<>() {
        public void handle(ActionEvent event) {
            if (!open_list.isEmpty()) {
                int best = 0;
                //sort by looking for lowest f value
                for (int i = 0; i < open_list.size(); i++) {
                    //System.out.println(open_list.get(i).getF_value());
                    if(open_list.get(i).getF_value() < open_list.get(best).getF_value()){
                        best = i;
                    }
                }
                Tile current = open_list.get(best);
                best_path = new ArrayList<>();
                Tile temp_node = current;
                best_path.add(current);
                while (temp_node.previous != null) {
                    best_path.add(temp_node.previous);
                    temp_node = temp_node.previous;
                }
                //draw functions for drawing the status of the algorithm
                draw_closed_set(closed_list);
                draw_best_path(best_path);
                draw_open_set(open_list);
                if (current == end_node) {
                    System.out.println("Win");
                    for (Tile t : nodes) {
                        if (!t.blocking) {
                            t.set_custom_color(Color.CYAN, Color.DARKCYAN);
                        }
                    }
                    draw_best_path(best_path);
                    Main.getUi().set_status_text("Route found");
                    tl.stop();
                    return;
                }
                //remove this node (current node) so that we dont check it on the next iteration of the loop
                open_list.remove(current);
                closed_list.add(current);

                //for each neighbour
                for (Tile n : current.adjacent_nodes) {
                    if (!closed_list.contains(n) && !n.blocking) { //ensure that the neighbour is not in the closed list, and is not a wall
                        int temp_g = current.g_value + current.calculate_h_value(current,n);
                        boolean better_path = false;

                        if (open_list.contains(n)) {
                            if (temp_g < n.g_value) {
                                //checks if the neighbour has a smaller g value than the current nod
                                n.g_value = temp_g; // update G for neighbour
                                better_path = true;
                            }
                        } else {
                            n.g_value = temp_g; // update G for neighbour
                            better_path = true;
                            open_list.add(n); //add neighbour to open list for next revolution of the algorithm
                        }
                        if (better_path) {
                            n.h_value = n.calculate_h_value(n,end_node); //update the heuristic value to the goal
                            n.previous = current;
                        }
                    }
                }
            } else {
                System.out.println("No route");
                Main.getUi().set_status_text("No route could be found");
                tl.stop();
            }
        }
    });
    // Function for getting a tiles neighbours
    private void set_neighbours() {
        for(int i = 0; i < nodes.size(); i++){
            Tile n = nodes.get(i);
            if (n.x != 0) {
                n.adjacent_nodes.add(nodes.get(i-1)); // left
            }
            if((i + 1) % grid_handler.getCurrent_size_width() != 0){
                if(i != nodes.size()-1){
                    n.adjacent_nodes.add(nodes.get(i+1)); // right
                }
            }
            if(n.y != 0){
                n.adjacent_nodes.add(nodes.get(i-grid_handler.getCurrent_size_width())); //above
            }
            if(n.y != grid_handler.getCurrent_size_height()-1){
                n.adjacent_nodes.add(nodes.get(i+grid_handler.getCurrent_size_width())); //below
            }
        }
    }
}
