import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

/*
 * The class tests out the code by prompting the user to try to undergo
 * a mock run of the julia application and prints out the time lapse
 * of java creating the same "dictionary" like structure for when a 
 * user wanted to see the vaccination records between countries.
 */
public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner choice= new Scanner(System.in);
		System.out.println("Type '1' for Vaccination Records");
		System.out.println("Type '2' for Hospilization Records");
		System.out.println("Please Type a Command Number or 'quit' to leave: ");
		System.out.println();
		
		String pick= choice.nextLine();
		
		if( pick.equals("1")) {
			try {
				final long startTime = System.nanoTime();
				vaccinations(args[0]);
				final long duration= System.nanoTime()-startTime;
				System.out.println("Execution time in nanoseconds: " + duration);
		        System.out.println("Execution time in seconds: " + duration / 1000000000.0);
			} catch (FileNotFoundException e) {
				System.out.println("problem");
				e.printStackTrace();
			}
		}
		else if(pick.equals("2")) {
			
		}
		
		choice.close();
	}
	
	
	
	
	public static void vaccinations(String fil) throws FileNotFoundException {
		
		Map<String, String> vaccs= new HashMap<String, String>();
		
		File file= new File(fil);
		Scanner sc= new Scanner(file);
		
		while(sc.hasNextLine()) {
			String[] line= sc.nextLine().split(",");
			//System.out.println(line);
			vaccs.put(line[1], line[2]);
		}
		
		
		sc.close();
		//System.out.println(vaccs);
	}

}
