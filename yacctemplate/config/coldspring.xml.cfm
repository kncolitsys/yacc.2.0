<?xml version="1.0" encoding="UTF-8"?>
<beans>
	<import resource="/yacc/config/coldspring.xml.cfm"/>
	
	<bean autowire="no" class="yacc.cfc.bean" id="settings" singleton="true">
		<constructor-arg name="properties">
			<map>
				<entry key="header">
					<value>EasyCFCMS</value>
				</entry>
				<entry key="host">
					<value>yourhost.com</value>
				</entry>
				<entry key="hostsecure">
					<value>yourhost.com</value>
				</entry>
				<entry key="path">
					<value>/yacctemplate</value>
				</entry>
				<entry key="yaccpath">
					<value>/yacc</value>
				</entry>
				<entry key="cfcpath">
					<value>yacctemplate.cfc</value>
				</entry>
				<entry key="template">
					<value>marketplace</value>
				</entry>
				<entry key="templatepath">
					<value/>
				</entry>
				<entry key="layouts">
					<value/>
				</entry>
				
				<entry key="cmstitle">
					<value>YACC</value>
				</entry>
				
				<entry key="url">
					<value>http://yourhost.com/yacctemplate</value>
				</entry>
				
				
			</map>
		</constructor-arg>
	</bean>
	
	
		
</beans>