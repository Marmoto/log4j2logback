<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">

    <appender name="consola" class="org.apache.log4j.ConsoleAppender">
        <layout class="org.apache.log4j.PatternLayout">
            <param name="ConversionPattern" value="[%d] - INT - %-5p [%t(%C{{1}}.%M)] %c{{1}} - %m%n"/>
        </layout>
    </appender>

    <appender name="fichero" class="org.apache.log4j.DailyRollingFileAppender">
        <param name="Append" value="true"/>
        <param name="File" value="../bin/log/Service.log"/>
        <param name="DatePattern" value="'.'yyyy-MM-dd-hh"/>
        <layout class="org.apache.log4j.PatternLayout">
            <param name="ConversionPattern" value="[%d] - INT - %-5p [%t(%C{{1}}.%M)] %c{{1}} - %m%n"/>
        </layout>
    </appender>

    <!--appender name="database" class="es.viesgo.sico.atenea.log.StorageAppender">
        <param name="ContextName" value="storage"/>
        <param name="Threshold" value="WARN"/>
        <layout class="org.apache.log4j.PatternLayout">
            <param name="ConversionPattern" value="[%d] %-5p [%t(%C{{1}}.%M)] %c{{1}} - %m%n"/>
        </layout>
    </appender-->

    <xsl:for-each select="configuration/deployList/deploy[@location=$deploy]/serviceList/service">
        <xsl:call-template name="service.appender"/>
    </xsl:for-each>

    <xsl:for-each select="configuration/deployList/deploy[@location=$deploy]/businessOp">
        <xsl:apply-templates select="."/>
    </xsl:for-each>

    <xsl:for-each select="configuration/deployList/deploy[@location=$deploy]/serviceList/service">
        <xsl:call-template name="service.loggers"/>
    </xsl:for-each>

    <!--category name="es.viesgo.sico">
        <appender-ref ref="database"/>
    </category-->

    <category name="es.viesgo.sico.atenea.storage">
        <priority value="ERROR"/>
    </category>

    <category name="es.viesgo.sico.atenea.util">
        <priority value="ERROR"/>
    </category>

    <category name="es.viesgo.sico.util.database">
        <priority value="ERROR"/>
    </category>

    <!--category name="java.sql">
        <priority value="ERROR"/>

        <xsl:for-each select="configuration/deployList/deploy[@location=$deploy]/businessOp/id">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </category-->

    <root>
        <priority value="DEBUG" />
        <appender-ref ref="consola"/>
        <appender-ref ref="fichero"/>

        <xsl:for-each select="configuration/deployList/deploy[@location=$deploy]/businessOp/id">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </root>

</log4j:configuration>
</xsl:template>

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

<xsl:template name="service.loggers">
    <category name="es.viesgo.sico.atenea.opservices.{@logger}">
        <priority value="ALL"/>
        <appender-ref ref="{.}"/>
    </category>

    <category name="es.viesgo.sico.atenea.helpers.{@logger}Helper">
        <priority value="ALL"/>
        <appender-ref ref="{.}"/>
    </category>

    <category name="es.viesgo.sico.atenea.handlers.{@logger}Handler">
        <priority value="ALL"/>
        <appender-ref ref="{.}"/>
    </category>
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

<xsl:template match="id">
    <appender-ref ref="{.}"/>
</xsl:template>

</xsl:stylesheet>
