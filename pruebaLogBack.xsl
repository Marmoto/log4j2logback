<xsl:template name="service.appender">
    <appender name="{.}" class="org.apache.log4j.DailyRollingFileAppender">
        <param name="Append" value="true"/>
        <param name="File" value="../bin/log/{.}.log"/>
        <param name="DatePattern" value="'.'yyyy-MM-dd-hh"/>
        <layout class="org.apache.log4j.PatternLayout">
            <param name="ConversionPattern" value="[%d] - INT - %-5p [%t(%C{{1}}.%M)] %c{{1}} - %m%n"/>
        </layout>
    </appender>
</xsl:template>

<xsl:template match="businessOp">
    <appender name="{id}" class="org.apache.log4j.DailyRollingFileAppender">
        <param name="Append" value="true"/>
        <param name="File" value="../bin/log/{id}.log"/>
        <param name="DatePattern" value="'.'yyyy-MM-dd"/>
        <layout class="org.apache.log4j.PatternLayout">
            <param name="ConversionPattern" value="[%d] - INT - %-5p [%t(%C{{1}}.%M)] %c{{1}} - %m%n"/>
        </layout>
        <filter class="org.apache.log4j.varia.StringMatchFilter">
            <param name="StringToMatch" value="{id}"/>
            <param name="AcceptOnMatch" value="true"/>
        </filter>
        <filter class="org.apache.log4j.varia.StringMatchFilter">
            <param name="StringToMatch" value=" "/>
            <param name="AcceptOnMatch" value="false"/>
        </filter>
        <filter class="org.apache.log4j.varia.StringMatchFilter">
            <param name="StringToMatch" value="="/>
            <param name="AcceptOnMatch" value="false"/>
        </filter>
    </appender>
</xsl:template>
