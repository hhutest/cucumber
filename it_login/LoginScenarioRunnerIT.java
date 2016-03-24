package login;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        format = {"pretty", "html:target/reports/login report", "json:target/cucumber.json"},
        features = "src/test/resources/features/Login.feature",
        tags = {"~@ignore"})
public class LoginScenarioRunnerIT {

}
