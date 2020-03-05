import fitness_app.core.Person;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;



class personTest {
    Person hussein = new Person("Hussein", "Miari", 92, 190, 20, "male"
            ,"Denmark", "Sjælland", "Smørum", "Erantishaven 4");

    @Test
    public void bmiTest(){
        Person julie = new Person("Julie", "W", 100, 200, 20, "female", "denmark", "s", "s", "s");
        //setting new values to this person, to test if the bmicalculater calculates new values too.
        julie.setWeight(57);
        julie.setHeight(160);
        julie.getBmi();
        // Julies BMI should be equal to 22,25, but we round down to 22 (math.round function), since the formula for BMI is weight divided by height in meters squared.
        assertEquals(julie.getBmi(), 22);
    }

    @Test
    public void emptyPersonTest(){
        Person emptyPerson = new Person();
        assertEquals(emptyPerson.getAge(), -1);
        assertEquals(emptyPerson.getWeight(), -1);
        assertEquals(emptyPerson.getHeight(), -1);
        assertEquals(emptyPerson.getFirstName(), "");
    }

    @Test
    public void createNewPersonTest(){
     Person anton = new Person("Anton", "Due", 98, 216, 21, "Male", "Denmark", "Sjælland", "Roskilde", "Pas");
     assertEquals(anton.getAge(), 21);
     anton.setAge(22);
     assertEquals(anton.getAge(), 22);
    }

    @Test
    public void getFieldFromConstructorTest(){
        assertEquals(hussein.getAge(), 20);
    }

    @Test
    public void setterTest(){
        hussein.print_person_details();
        hussein.setAge(21);
        hussein.print_person_details();
        assertEquals(21, hussein.getAge());
   }
}