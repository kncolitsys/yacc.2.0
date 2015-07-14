<?xml version="1.0" encoding="UTF-8"?>
<transfer xsi:noNamespaceSchemaLocation="../../../transfer/resources/xsd/transfer.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<objectDefinitions>
		<package name="page">
			<object name="nugget" table="nugget">
				<id name="id" type="string"/>
				
				<property name="content" type="string"/>
				<property name="updatedOn" type="date"/>
				<manytoone name="updatedBy">
					<link to="user.user" column="updatedBy" />
				</manytoone>
			</object>
			
			<object name="page" table="page" decorator="yacc.cfc.decorator.page">
				<id name="path" type="string"/>
				<property name="title" type="string"/>
				<property name="layout" type="string"/>
				<property name="updatedOn" type="date"/>
				<manytoone name="updatedBy">
					<link to="user.user" column="updatedBy" />
				</manytoone>
				
				
			</object>
			
			<object name="section" table="section">
				<compositeid>
					<property name="path"/>
					<property name="id"/>
				</compositeid>
				<property name="path" type="string"/>
				<property name="id" type="string"/>
				<property name="content" type="string"/>
				<property name="updatedOn" type="date"/>
				<manytoone name="updatedBy">
					<link to="user.user" column="updatedBy" />
				</manytoone>
			</object>
		</package>
		<package name="user">
			<object name="user" table="person" decorator="yacc.cfc.decorator.user">
				<id name="userid" type="numeric"/>
				<property name="username" type="string" />
				<property name="password" type="string" />
				<property name="firstName" type="string" />
				<property name="lastName" type="string" />
				<property name="email" type="string" />
				<property name="isAdmin" type="boolean" />
				<property name="currentToken" type="string" />
			</object>
			
		</package>
	</objectDefinitions>
</transfer>