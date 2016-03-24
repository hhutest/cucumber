package search;

import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class SearchInJobFileScenario extends AbstractWebBrowserScenario {

    private SearchPage searchPage;

    @Before("@userAuthenticatedAs_tuser")
    public void setUp() throws Exception {
        createDriver();
        LoginPage loginPage = PageFactory.initElements(webDriver, LoginPage.class);
        loginPage.initFieldNamesMapping();
        loginPage.setFieldValue(new PageFieldValue("login", "tuser"));
        loginPage.setFieldValue(new PageFieldValue("password", "Qwerty123"));
        loginPage.clickLoginButton();
    }

    @Before("@userAuthenticatedAs_test_DE")
    public void setUpTest_DE() throws Exception {
        createDriver();
        LoginPage loginPage = PageFactory.initElements(webDriver, LoginPage.class);
        loginPage.initFieldNamesMapping();
        loginPage.setFieldValue(new PageFieldValue("login", "test_de@mail.com"));
        loginPage.setFieldValue(new PageFieldValue("password", "QD49gHZC"));
        loginPage.clickLoginButton();
    }

    @After
    public void tearDown() throws Exception {
        webDriver.close();
        webDriver.quit();
    }

    @Given("^User on search page")
    public void loginToSite() {
        searchPage = PageFactory.initElements(webDriver, SearchPage.class);
        assertTrue(searchPage.isSearchPage());
    }

    @When("^User enters the search data:$")
    public void doSearchQuery(List<PageFieldValue> fields) {
        searchPage.initFieldNamesMapping();
        for (PageFieldValue field : fields) {
            searchPage.setFieldValue(field);
        }
    }

    @When("^User open help window$")
    public void pressHelpButton() {
        searchPage.pressHelpButton();
    }

    @And("^User select search syntax - \"(.*)\"$")
    public void selectSearchOperation(String nameButton) {
        assertEquals(nameButton, searchPage.selectSearchType(nameButton));
    }

    @And("^User select german search syntax - \"(.*)\"$")
    public void selectGermanSearchOperation(String nameButton) {
        assertEquals(nameButton, searchPage.selectGermanSearchType(nameButton));
    }

    @And("^User select the blank$")
    public void pressSingleWordSearchButton() {
        searchPage.pressSingleWordButton();
    }

    @And("^User press \"(.*)\" button$")
    public void pressButton(String nameButton) {
        assertEquals(nameButton, searchPage.pressButton(nameButton));
    }

    @Then("^User should see result table with message with total is \"(.*)\"$")
    public void seeResultTotalTableAfterSearching(String totalResultTable) {
        assertEquals(totalResultTable, searchPage.getTextOfTotalTableResult());
    }

    @Then("^User should see message \"(.*)\" after action$")
    public void seeMessage(String messageText) {
        assertEquals(messageText, searchPage.getMessageText());
    }

    @And("^Change text search to Advanced$")
    public void Change_text_search_to_Advanced() throws Throwable {
        searchPage.clickSearchTypeChangerButton();
    }
}
