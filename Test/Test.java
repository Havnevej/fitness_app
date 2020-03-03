import fitness_app.core.Person;
import org.junit.jupiter.api.Test;

import java.util.logging.SocketHandler;

import static org.junit.jupiter.api.Assertions.*;



class test {
    Person hussein = new Person("Hussein", "Miari", 92, 190, 20, "male"
            ,"Denmark", "Sjælland", "Smørum", "Erantishaven 4");
    @Test
    public void setterTest(){
        hussein.print_person_details();
        hussein.setAge(21);
        hussein.print_person_details();
        assertEquals(21, hussein.getAge());
    }
    @Test
    public void emptyPersonTest(){

    }
}
