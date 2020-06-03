package fitness_group.astar;

import java.util.ArrayList;
import java.util.Random;

class Grid_Handler { //handler class for the grid layout
    private ArrayList<Tile> tiles = new ArrayList<>();
    private int box_width = 60, box_height = 60;
    private int start_tile;
    private int end_tile;
    private int current_size_height;
    private int current_size_width;

    private int blockers = 0;
    private Random r = new Random();

    Grid_Handler(){
        generate_grid(12,8, true);
    } //constructor generates a grid with hardcoded size

    int getBox_height() { return box_height; }
    int getBox_width() { return box_width; }
    int getCurrent_size_height() { return current_size_height; }
    int getCurrent_size_width() { return current_size_width;}
    public int getCurrent_size_total() { return current_size_width*current_size_height;}

    private void setCurrent_size_height(int current_size_height) { this.current_size_height = current_size_height; }
    private void setCurrent_size_width(int current_size_width) { this.current_size_width = current_size_width; }

    int getBlockers() { return blockers; }
    void setBlockers(int blockers) { this.blockers = blockers; }
    int getEnd_tile() { return end_tile; }
    int getStart_tile() { return start_tile; }

    ArrayList<Tile> getTiles() { return tiles; }

    private void display_grid(){
        for(Tile t : getTiles()){
            t.update_tile();
        }
    }

    void generate_grid(int size_width, int size_height, boolean lines) {
        tiles.clear();
        Main.root.getChildren().clear(); //root is anchorpane

        setCurrent_size_height(size_height);
        setCurrent_size_width(size_width);

        ArrayList<Tile> grid_temp = new ArrayList<>();
        int i = 0;
        for (int y = 0; y < size_height; ++y) {//Iterate through columns
            for (int x = 0; x < size_width; ++x) {//Iterate through rows
                grid_temp.add(new Tile(box_width * x, box_height * y, x, y, box_width, box_height, i));
                i++;
            }
        }
        this.tiles = populate_grid(grid_temp, lines);
        display_grid();
    }
    private ArrayList<Tile> populate_grid (ArrayList<Tile> list, boolean is_lines){
        generate_blockers(list);
        if(is_lines) {
            list = generate_start(list, 36);
            list = generate_end(list, 3);
            generate_blockers(list);
        } else {
            list = generate_start(list, 0);
            list = generate_end(list, list.size()-1);
        }
        return list;
    }
    // for specific blocker generation according to the task description
    private void generate_blockers(ArrayList<Tile> list){
        ArrayList<Integer> blockers = new ArrayList<>(){
            {
                add(0);
                add(5);
                add(6);
                add(7);
                add(12);
                add(14);
                add(16);
                add(17);
                add(19);
                add(21);
                add(22);
                add(24);
                add(26);
                add(28);
                add(33);
                add(34);
                add(38);
                add(40);
                add(42);
                add(44);
                add(45);
                add(48);
                add(50);
                add(52);
                add(54);
                add(56);
                add(60);
                add(62);
                add(66);
                add(68);
                add(70);
                add(72);
                add(74);
                add(75);
                add(76);
                add(77);
                add(78);
                add(82);
                add(84);
                add(92);
                add(93);
                add(94);
            }
        };
        for(Tile t : list){
            if(blockers.contains(t.id)){
                t.set_blocking();
            }
        }
    }
    // if you wanted to generate a random start block in the top row
    private ArrayList<Tile> generate_start(ArrayList<Tile> list){
        start_tile = r.nextInt(this.getCurrent_size_width());
        list.get(start_tile).setIs_start();
        return list;
    }

    ArrayList<Tile> generate_start(ArrayList<Tile> list, int id){
        start_tile = id;
        list.get(id).setIs_start();
        return list;
    }
    // if you wanted to generate a random start block in the bottom row
    private ArrayList<Tile> generate_end(ArrayList<Tile> list){
        end_tile = r.nextInt((list.size()-(list.size()-this.getCurrent_size_width())))+list.size()-this.getCurrent_size_width();
        list.get(end_tile).setIs_end();
        return list;
    }
    ArrayList<Tile> generate_end(ArrayList<Tile> list, int id){
        end_tile = id;
        list.get(id).setIs_end();
        return list;
    }
}
