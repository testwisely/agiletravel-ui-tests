import org.junit.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class LoginTestCase {
    static WebDriver driver;

    @BeforeClass
    public static void setUp() throws Exception {
        driver = new ChromeDriver();
        driver.get("https://travel.agileway.net");
    }

    @AfterClass
    public static void tearDown() {
        driver.quit();
    }

    @Test
    public void testSignInFailed() {
        LoginPage loginPage = new LoginPage(driver);
        loginPage.enterUsername("agileway");
        loginPage.enterPassword("guess");
        loginPage.clickSignIn();
        assert driver.findElement(By.tagName("body")).getText().contains("Invalid");
    }

    @Test
    public void testSignInOK() {
        LoginPage loginPage = new LoginPage(driver);
        loginPage.enterUsername("agileway");
        loginPage.enterPassword("testwise");
        loginPage.clickSignIn();
        assert driver.findElement(By.tagName("body")).getText().contains("Signed in!");
    }


}