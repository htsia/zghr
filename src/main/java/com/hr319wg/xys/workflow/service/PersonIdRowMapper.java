package com.hr319wg.xys.workflow.service;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class PersonIdRowMapper implements RowMapper {

	public Object mapRow(ResultSet res, int arg1) throws SQLException {
		String value=res.getString("person_id");
		return value;
	}

}
