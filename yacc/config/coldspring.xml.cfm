<beans>
	
	<bean id="defaults" class="yacc.cfc.bean" singleton="true" autowire="no">
		<constructor-arg name="properties">
			<map>
				<entry key="layout">
					<value>default</value>
				</entry>
				<entry key="id">
					<value>yacccontents</value>
				</entry>
				<entry key="template">
					<value></value>
				</entry>
			</map>
		</constructor-arg>
	</bean>
	
	<bean id="debug" class="yacc.cfc.bean" singleton="true" autowire="no">
		<constructor-arg name="properties">
			<map>
				<entry key="show">
					<value>FALSE</value>
				</entry>
				<entry key="session">
					<value>TRUE</value>
				</entry>
				<entry key="cgi">
					<value>TRUE</value>
				</entry>
				<entry key="form">
					<value>TRUE</value>
				</entry>
				<entry key="url">
					<value>TRUE</value>
				</entry>
				<entry key="application">
					<value>FALSE</value>
				</entry>
				<entry key="exception">
					<value>TRUE</value>
				</entry>
				<entry key="server">
					<value>FALSE</value>
				</entry>
			</map>
		</constructor-arg>
	</bean>
	
	
	
	
		
	<bean id="TransferFactory" class="transfer.TransferFactory" singleton="true" autowire="no">
		<constructor-arg name="datasourcePath">
			<value>/yacc/config/transfer/datasource.xml.cfm</value>
		</constructor-arg>
		<constructor-arg name="configPath">
			<value>/yacc/config/transfer/transfer.xml.cfm</value>
		</constructor-arg>
		<constructor-arg name="definitionPath">
			<value>/yacc/config/transfer/definitions</value>
		</constructor-arg>
	</bean>

	<bean id="Transfer" factory-bean="TransferFactory" factory-method="getTransfer" />
	<bean id="Datasource" factory-bean="TransferFactory" factory-method="getDatasource" />
	<bean id="Transaction" factory-bean="TransferFactory" factory-method="getTransaction" />
	
	<bean id="pageService" class="yacc.cfc.services.pageService">
		<constructor-arg name="transfer">
			<ref bean="transfer"/>
		</constructor-arg>
		<constructor-arg name="defaults">
			<ref bean="defaults"/>
		</constructor-arg>
		<constructor-arg name="settings">
			<ref bean="settings"/>
		</constructor-arg>
		<singleton>TRUE</singleton>
	</bean>
	
	<bean id="userService" class="yacc.cfc.services.userService">
		<constructor-arg name="transfer">
			<ref bean="transfer"/>
		</constructor-arg>
		<constructor-arg name="yaccsettings">
			<ref bean="yaccsettings"/>
		</constructor-arg>
		<singleton>TRUE</singleton>
	</bean>
	
	<bean id="login" class="yacc.cfc.login">
		<singleton>TRUE</singleton>
	</bean>
	
	<bean id="yaccsettings" class="yacc.cfc.bean" singleton="true" autowire="no">
		<constructor-arg name="properties">
			<map>
				<entry key="header">
					<value>YACC Test</value>
				</entry>
				<entry key="AdminEmail">
					<value>email@yourhost.com</value>
				</entry>
				<entry key="host">
					<value>yourhost.com</value>
				</entry>
				<entry key="hostsecure">
					<value>yourhost.com</value>
				</entry>
				<entry key="yaccpath">
					<value>/yacc</value>
				</entry>
				
				<entry key="template">
					<value>elitecircle</value>
				</entry>
				
				<entry key="cmstitle">
					<value>YACC</value>
				</entry>
				
				<entry key="templates">
					<value></value>
				</entry>
				
				<entry key="url">
					<value>http://yourhost.com/yacc</value>
				</entry>
				<entry key="cookiesecret">
					<value>YakAttack!</value>
				</entry>
				<entry key="cookieExpirationUnit">
					<value>d</value>
				</entry>
				<entry key="cookieExpirationCount">
					<value>1</value>
				</entry>
				
				<entry key="forceHTTPSonLogin">
					<value>FALSE</value>
				</entry>
			</map>
		</constructor-arg>
	</bean>

		
</beans>