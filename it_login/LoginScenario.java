package login;

import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

import static org.junit.Assert.assertEquals;

public class LoginScenario extends AbstractWebBrowserScenario {

    private LoginPage loginPage;
    private SearchPage searchPage;
    private DialogLoginPage dialogLoginPage;

    @Before
    public void setUp() throws Exception {
        createDriver();
    }

    @After
    public void tearDown() throws Exception {
        webDriver.close();
        webDriver.quit();
    }

    @Given("^User on login page$")
    public void connectToWebSiteJobFile() {
    }

    @When("^User fill login form:$")
    public void fillFieldLoginPassword(List<PageFieldValue> fields) {
        loginPage = PageFactory.initElements(webDriver, LoginPage.class);
        loginPage.initFieldNamesMapping();
        for (PageFieldValue field : fields) {
            loginPage.setFieldValue(field);
        }
    }

    @Then("^User should see \"(.*)\" form title$")
    public void seeLogoutButton(String searchLabelText) {
        searchPage = PageFactory.initElements(webDriver, SearchPage.class);
        assertEquals(searchLabelText, searchPage.geTextSearchFormTitle());
    }

    @And("^User should see \"(.*)\" button$")
    public void showTextLogOutButton(String nameButton) {
        assertEquals(nameButton, loginPage.getNameLogOutButton().getText());
    }

    @Then("^User should see message \"(.*)\"$")
    public void seeErrorMessage(String errorMessageText) {
        assertEquals(errorMessageText, loginPage.getErrorMessageText());
    }

    @And("^All cookies was clear$")
    public void deleteCookies() {
        webDriver.manage().deleteAllCookies();
    }

    @Then("^User should see message \"(.*)\" about stop cookies$")
    public void seeCookiesErrorMessage(String errorCookiesMessageText) throws Exception {
        Thread.sleep(1000);
        assertEquals(errorCookiesMessageText, loginPage.getCookiesStopMessage());
    }

    @When("^User try to logout$")
    public void tryLogout() {
        loginPage.getNameLogOutButton().click();
    }

    @And("^User should see dialog login page with \"(.*)\" title$")
    public void showDialogWindow(String dialogTitle) {
        dialogLoginPage = PageFactory.initElements(webDriver, DialogLoginPage.class);
        assertEquals(dialogTitle, dialogLoginPage.getDialogTitleText());
    }

    @And("^User press signIn button$")
    public void pressButton() {
        loginPage.clickLoginButton();
    }

    @And("^User press submit signIn button$")
    public void submitLogin() {
        dialogLoginPage.submitLogin();
    }

    @When("^User fill login form again:$")
    public void loginToSiteAgain(List<PageFieldValue> fields) {
        dialogLoginPage.initFieldNamesMapping();
        for (PageFieldValue field : fields) {
            dialogLoginPage.setFieldValue(field);
        }
    }
}
