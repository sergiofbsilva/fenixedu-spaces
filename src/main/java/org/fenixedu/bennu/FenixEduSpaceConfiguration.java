package org.fenixedu.bennu;

import org.fenixedu.commons.configuration.ConfigurationInvocationHandler;
import org.fenixedu.commons.configuration.ConfigurationManager;
import org.fenixedu.commons.configuration.ConfigurationProperty;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan("org.fenixedu.spaces")
public class FenixEduSpaceConfiguration {
    @ConfigurationManager(description = "Fenix Space Configuration")
    public interface ConfigurationProperties {
        @ConfigurationProperty(key = "scaleRatio", defaultValue = "1200")
        public String scaleRatio();

        @ConfigurationProperty(key = "fontSize", defaultValue = "0.007")
        public String fontSize();

        @ConfigurationProperty(key = "padding", defaultValue = "0.025")
        public String padding();

        @ConfigurationProperty(key = "xAxisOffset", defaultValue = "0.075")
        public String xAxisOffset();

        @ConfigurationProperty(key = "yAxisOffset", defaultValue = "0.3")
        public String yAxisOffset();

    }

    public static ConfigurationProperties getConfiguration() {
        return ConfigurationInvocationHandler.getConfiguration(ConfigurationProperties.class);
    }

}