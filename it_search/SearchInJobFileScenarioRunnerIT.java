package search;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        format = {"pretty", "html:target/reports/search report", "json:target/cucumber.json"},
        features = "src/test/resources/features/Search.feature",
        tags = {"~@ignore"})
public class SearchInJobFileScenarioRunnerIT {

}
