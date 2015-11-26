import java.util.Scanner;
public class Ejemplo{
	public static void main(String[] args){
		String msg = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut laoreet orci id fermentum imperdiet. Phasellus vel dui elementum, lobortis est sit amet, rutrum eros. Cras vel sem augue. Ut ac massa vel ipsum viverra ullamcorper ac a nisi. Integer vehicula ligula id ex tempus ultricies. Nullam congue imperdiet maximus. Fusce nec velit enim. Mauris pretium blandit nibh, eget congue lectus euismod id.";
		String p = "sit";
		int n = msg.length();
		int m = p.length();
		int i=0;
		while(i<n-m){
		//for(int i=0; i<n-m; ++i){
			int j=0;
			while(j<m && msg.charAt(i+j)==p.charAt(j)){
				++j;
			}
			if(j == m){
				System.out.println("Si esta!");
				return;
			}
			i++;
		}
		System.out.println("No esta!");
	}
}
