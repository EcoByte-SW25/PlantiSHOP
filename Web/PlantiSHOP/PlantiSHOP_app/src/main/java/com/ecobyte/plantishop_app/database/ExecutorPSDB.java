package com.ecobyte.plantishop_app.database;

import java.math.BigDecimal;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Map;

import com.ecobyte.plantishop_app.database.*;
import com.ecobyte.plantishop_app.exceptions.*;

/**
 * Creates, prepares, fills and executes SQL Statements depending on the given
 * input.
 *
 * Given a specific table, it can return the name of each field in the database
 * by {@link #getTableFields()}, the name of each type with their correspondant
 * field name as key by {@link #getTableTypes()}, create select, insert, update
 * and delete statements with their respective values and conditions format, and
 * prepare the correct data to be used on the statement.
 *
 * @see GZDBConnector
 * @author Glamdring (Σxz)
 * @version 1.3.1
 * @since 0.1
 */
public class ExecutorPSDB {

    /**
     * Constant value that references the '{@code &nbsp;}' character, utilized
     * for constructing statements
     */
    private final char SPACE_CHAR = 32;
    /**
     * Constant value that references the '{@code *}' character, utilized for
     * select statements
     */
    private final char EVERYTHING_CHAR = 42;
    /**
     * Constant value that references the '{@code ,}' character, utilized for
     * separating elements of a statement.
     */
    private final char COMMA_CHAR = 44;
    /**
     * Constant value that references the '{@code =}' character, utilized for
     * establishing comparatives with different variables and values.
     */
    private final char EQUAL_CHAR = 61;
    /**
     * Constant value that references the '{@code ?}' character, utilized for
     * constructing prepared statements,
     */
    private final char QUESTION_CHAR = 63;
    /**
     * Constant value that references the {@code AND} operator in a string,
     * utilized for setting up different conditions on a statement.
     */
    private final String AND_OPERATOR = "AND";

    /**
     * Constructs SQL Statements piece by piece.
     */
    private StringBuilder statementBuilder;

    /**
     * Establishes a connection to the MySQL Server
     */
    private final Connection connection;
    /**
     * Determines an action to be done, like select, insert, update and delete,
     * for a more technical overview @see GZDBActions
     */
    private final ActionsPSDB action;
    /**
     * Determines the table to use when executing any SQL Statements, for a more
     * technical overview @see GZDBTables
     */
    private final TablesPSDB table;
    /**
     * Prepares a statement string value with a specified format that gets
     * filled with the defined data input, it is next executed in the MySQL
     * Server with every argument filled.
     */
    private PreparedStatement preparedStatement;

    /**
     * Assigns each parameter to their private field equivalent for usage on
     * executing SQL Statements.
     *
     * @param preparedStatement The object that executes every SQL Statement.
     * @param connection A MySQL Server connection.
     * @param action The defined action to be executed on a table.
     * @param table The defined table to execute actions in.
     */
    public ExecutorPSDB(Connection connection, PreparedStatement preparedStatement, ActionsPSDB action, TablesPSDB table) {
        this.connection = connection;
        this.preparedStatement = preparedStatement;
        this.action = action;
        this.table = table;
    }

    /**
     * Executes the {@code DESCRIBE} statement in the MySQL Server with the
     * already defined table.
     *
     * @return A SQL ResultSet containing the table's information, like field
     * names, data types and others.
     * @throws SQLException In case the table doesn't exist.
     */
    private ResultSet describeTable() throws SQLException {
        preparedStatement = connection.prepareStatement("DESCRIBE " + table.getTable());
        ResultSet resultDescriptionSet = preparedStatement.executeQuery();
        return resultDescriptionSet;
    }

    /**
     * Utilizes the {@link #describeTable()} method to extract only the names of
     * each field in the specified table.
     *
     * @return A set with the name of each field inside a table in the MySQL
     * Server.
     * @throws SQLException Refer to {@link #describeTable()}
     */
    public LinkedHashSet<String> getTableFields() throws SQLException {
        LinkedHashSet<String> fieldsSet = new LinkedHashSet<>();
        ResultSet resultSet = describeTable();
        while (resultSet.next()) {
            fieldsSet.add(resultSet.getString(ReservedPSDB.FIELD.getKeyword()));
        }
        return fieldsSet;
    }

    /**
     * Utilizes the {@link #describeTable()} method to extract the data type of
     * each field, including the name of the field.
     *
     * @return A map with the name of each data type inside a table in the MySQL
     * Server, with the names of each field as keys.
     * @throws SQLException Refer to {@link #describeTable()}
     */
    public LinkedHashMap<String, String> getTableTypes() throws SQLException {
        LinkedHashMap<String, String> typesMap = new LinkedHashMap<>();
        ResultSet resultSet = describeTable();
        while (resultSet.next()) {
            typesMap.put(
                    resultSet.getString(ReservedPSDB.FIELD.getKeyword()),
                    resultSet.getString(ReservedPSDB.TYPE.getKeyword()));
        }
        return typesMap;
    }

    /**
     * Adds each result of a SQL Select statement execution with the data type
     * as key into an array list for easier management of multiple results. See
     * {@link #executeSelect(LinkedHashMap<String, Object>)}
     *
     * @param resultSet Data returned by a SQL Select statement execution.
     * @param typesMap A map containing the data types with the field names as
     * keys. See {@link #getTableTypes()}
     * @return A list containing maps with each returning value from the result
     * set and the field name as key.
     * @throws SQLException If the ResultSet object cannot be resolved
     * correctly.
     */
    private ArrayList<LinkedHashMap<String, Object>> getResultMapWithWhereClause(ResultSet resultSet, LinkedHashMap<String, String> typesMap) throws SQLException {
        ArrayList<LinkedHashMap<String, Object>> resultList = new ArrayList<>();
        while (resultSet.next()) {
            LinkedHashMap<String, Object> resultMap = new LinkedHashMap<>();
            for (String outputField : typesMap.keySet()) {
                if (typesMap.get(outputField).equals(ReservedPSDB.BOOLEAN.getKeyword())) {
                    resultMap.put(outputField, resultSet.getBoolean(outputField));
                } else if (typesMap.get(outputField).equals(ReservedPSDB.INT.getKeyword())) {
                    resultMap.put(outputField, resultSet.getInt(outputField));
                } else if (typesMap.get(outputField).contains(ReservedPSDB.DECIMAL.getKeyword())) {
                    resultMap.put(outputField, resultSet.getBigDecimal(outputField));
                } else if (typesMap.get(outputField).contains(ReservedPSDB.VARCHAR.getKeyword())) {
                    resultMap.put(outputField, resultSet.getString(outputField));
                } else if (typesMap.get(outputField).equals(ReservedPSDB.TEXT.getKeyword())) {
                    resultMap.put(outputField, resultSet.getString(outputField));
                } else if (typesMap.get(outputField).equals(ReservedPSDB.DATE.getKeyword())) {
                    resultMap.put(outputField, resultSet.getDate(outputField));
                } else if (typesMap.get(outputField).equals(ReservedPSDB.TIME.getKeyword())) {
                    resultMap.put(outputField, resultSet.getTime(outputField));
                } else if (typesMap.get(outputField).equals(ReservedPSDB.DATETIME.getKeyword())) {
                    resultMap.put(outputField, resultSet.getTimestamp(outputField));
                } else if (typesMap.get(outputField).equals(ReservedPSDB.MEDIUMBLOB.getKeyword())) {
                    if (!resultSet.wasNull()) {
                        resultMap.put(outputField, resultSet.getBlob(outputField));
                    } else {
                        resultMap.put(outputField, null);
                    }
                }
            }
            resultList.add(resultMap);
        }
        return resultList;
    }

    /**
     * Fills up a prepared statement with the a map containing the field names
     * and data.
     *
     * @param preparedStatement Contains a SQL Statement with undefined values.
     * @param inputMap All the data that will fill the {@code PreparedStatement}
     * object with their respective field names.
     * @param typesMap A map containing the data types with the field names as
     * keys. See {@link #getTableTypes()}.
     * @return The {@code PreparedStatement} argument filled with data in each
     * required position.
     * @throws SQLException If the {@code PreparedStatement} object cannot be
     * resolved correctly.
     */
    private PreparedStatement setPreparedStatementArguments(PreparedStatement preparedStatement, LinkedHashMap<String, Object> inputMap, LinkedHashMap<String, String> typesMap) throws SQLException {
        int index = 1;
        for (String inputField : inputMap.keySet()) {
            if (typesMap.get(inputField).equals(ReservedPSDB.BOOLEAN.getKeyword())) {
                preparedStatement.setBoolean(index, (Boolean) inputMap.get(inputField));
            } else if (typesMap.get(inputField).equals(ReservedPSDB.INT.getKeyword())) {
                preparedStatement.setInt(index, (Integer) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.DECIMAL.getKeyword())) {
                preparedStatement.setBigDecimal(index, (BigDecimal) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.VARCHAR.getKeyword())) {
                preparedStatement.setString(index, (String) inputMap.get(inputField));
            } else if (typesMap.get(inputField).equals(ReservedPSDB.TEXT.getKeyword())) {
                preparedStatement.setString(index, (String) inputMap.get(inputField));
            } else if (typesMap.get(inputField).equals(ReservedPSDB.DATE.getKeyword())) {
                preparedStatement.setDate(index, (Date) inputMap.get(inputField));
            } else if (typesMap.get(inputField).equals(ReservedPSDB.TIME.getKeyword())) {
                preparedStatement.setTime(index, (Time) inputMap.get(inputField));
            } else if (typesMap.get(inputField).equals(ReservedPSDB.DATETIME.getKeyword())) {
                preparedStatement.setTimestamp(index, (Timestamp) inputMap.get(inputField));
            } else if (typesMap.get(inputField).equals(ReservedPSDB.MEDIUMBLOB.getKeyword())) {
                preparedStatement.setBlob(index, (Blob) inputMap.get(inputField));
            }
            index++;
        }
        return preparedStatement;
    }

    /**
     * Fills up a prepared statement with the a map containing the field names
     * and data.
     *
     * @param preparedStatement Contains a SQL Statement with undefined values,
     * consisting of two segments, insertion and selection.
     * @param inputMap All the data that will fill the {@code PreparedStatement}
     * object with their respective field names on the insertion segment.
     * @param selectMap All the data that will fill the
     * {@code PreparedStatement} object with their respective field names on the
     * selection segment.
     * @param typesMap A map containing the data types with the field names as
     * keys. See {@link #getTableTypes()}
     * @return The {@code PreparedStatement} argument filled with data in each
     * required position of both segments.
     * @throws SQLException If the {@code PreparedStatement} object cannot be
     * resolved correctly.
     */
    private PreparedStatement setPreparedStatementArguments(PreparedStatement preparedStatement, LinkedHashMap<String, Object> inputMap, LinkedHashMap<String, Object> selectMap, LinkedHashMap<String, String> typesMap) throws SQLException {
        int index = 1;
        for (String inputField : inputMap.keySet()) {
            if (typesMap.get(inputField).contains(ReservedPSDB.BOOLEAN.getKeyword())) {
                preparedStatement.setBoolean(index, (Boolean) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.INT.getKeyword())) {
                preparedStatement.setInt(index, (Integer) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.DECIMAL.getKeyword())) {
                preparedStatement.setBigDecimal(index, (BigDecimal) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.VARCHAR.getKeyword())) {
                preparedStatement.setString(index, (String) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.TEXT.getKeyword())) {
                preparedStatement.setString(index, (String) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.DATE.getKeyword())) {
                preparedStatement.setDate(index, (Date) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.TIME.getKeyword())) {
                preparedStatement.setTime(index, (Time) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.DATETIME.getKeyword())) {
                preparedStatement.setTimestamp(index, (Timestamp) inputMap.get(inputField));
            } else if (typesMap.get(inputField).contains(ReservedPSDB.MEDIUMBLOB.getKeyword())) {
                preparedStatement.setBlob(index, (Blob) inputMap.get(inputField));
            }
            index++;
        }
        for (String selectField : selectMap.keySet()) {
            if (typesMap.get(selectField).contains(ReservedPSDB.BOOLEAN.getKeyword())) {
                preparedStatement.setBoolean(index, (Boolean) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.INT.getKeyword())) {
                preparedStatement.setInt(index, (Integer) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.DECIMAL.getKeyword())) {
                preparedStatement.setBigDecimal(index, (BigDecimal) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.VARCHAR.getKeyword())) {
                preparedStatement.setString(index, (String) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.TEXT.getKeyword())) {
                preparedStatement.setString(index, (String) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.DATE.getKeyword())) {
                preparedStatement.setDate(index, (Date) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.TIME.getKeyword())) {
                preparedStatement.setTime(index, (Time) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.DATETIME.getKeyword())) {
                preparedStatement.setTimestamp(index, (Timestamp) selectMap.get(selectField));
            } else if (typesMap.get(selectField).contains(ReservedPSDB.MEDIUMBLOB.getKeyword())) {
                preparedStatement.setBlob(index, (Blob) selectMap.get(selectField));
            }
            index++;
        }
        return preparedStatement;
    }

    /**
     * Creates a {@code VALUE} clause for an SQL Insert statement.
     *
     * @param insertMap Defines which fields will have their default values and
     * which will be inserted.
     * @param typesMap A map containing the data types with the field names as
     * keys. See {@link #getTableTypes()}
     * @return A {@code VALUE} clause in a string format to be appended into a
     * full SQL Insert Statement.
     */
    private String makeSelectValueClause(LinkedHashMap<String, Object> insertMap, LinkedHashMap<String, String> typesMap) {
        StringBuilder valueClause = new StringBuilder();
        int index = 0;
        int total = typesMap.size();
        valueClause.append("(");
        for (Map.Entry<String, String> typeMap : typesMap.entrySet()) {
            index++;
            String type = typeMap.getKey();
            if (!insertMap.containsKey(type)) {
                if (index != total) {
                    valueClause.append("DEFAULT, ");
                } else {
                    valueClause.append("DEFAULT)");
                }
            } else {
                if (index != total) {
                    valueClause.append("?, ");
                } else {
                    valueClause.append("?)");
                }
            }
        }
        return valueClause.toString();
    }

    /**
     * Creates a SQL Insert statement to be used for further execution.
     *
     * @param insertMap Helps creating the {@code VALUE} clause, see
     * {@link #makeSelectValueClause(LinkedHashMap<String, Object>,
     * LinkedHashMap<String, String>)}
     * @param typesMap A map containing the data types with the field names as
     * keys. See {@link #getTableTypes()}
     * @return A SQL Insert Statement string with the adequate format and ready
     * to be filled.
     */
    private String getInsertStatement(LinkedHashMap<String, Object> insertMap, LinkedHashMap<String, String> typesMap) {
        statementBuilder = new StringBuilder();
        statementBuilder.append(action.getAction());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.INTO.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(table.getTable());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.VALUES.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(makeSelectValueClause(insertMap, typesMap));
        return statementBuilder.toString();
    }

    /**
     * Executes a SQL Insert Statement into the predefined table.
     *
     * @param insertMap A map containing all the data to be inserted, with the
     * field names as keys.
     * @throws SQLException If the statement is not able to be executed.
     */
    public void executeInsert(LinkedHashMap<String, Object> insertMap) throws SQLException {
        LinkedHashMap<String, String> typesMap = getTableTypes();
        String statement = getInsertStatement(insertMap, typesMap);
        preparedStatement = connection.prepareStatement(statement);
        preparedStatement = setPreparedStatementArguments(preparedStatement, insertMap, typesMap);
        preparedStatement.executeUpdate();
    }

    /**
     * Creates a {@code WHERE} clause with defined conditions to look for in the
     * table.
     *
     * @param selectMap A map containing all the values of each condition to be
     * met and their respective fields to be applied on.
     * @return A {@code WHERE} clause in a string format to be appended into a
     * full SQL Select Statement.
     * @throws SQLException If the method {@link #getTableFields()} does not run
     * correctly.
     * @throws ResultExceptionPSDB If the field to be selected is not contained
     * in the table.
     */
    private String makeWhereClause(LinkedHashMap<String, Object> selectMap) throws SQLException, ResultExceptionPSDB {
        int index = 0;
        StringBuilder whereClause = new StringBuilder();
        LinkedHashSet<String> fieldsSet = getTableFields();
        for (String inputField : selectMap.keySet()) {
            if (!fieldsSet.contains(inputField)) {
                throw new ResultExceptionPSDB(ExceptionMessagesPSDB.SELECT_NOFIELD, selectMap);
            }
            whereClause.append(inputField);
            whereClause.append(SPACE_CHAR);
            whereClause.append(EQUAL_CHAR);
            whereClause.append(SPACE_CHAR);
            whereClause.append(QUESTION_CHAR);
            index++;
            if (index != selectMap.size()) {
                whereClause.append(SPACE_CHAR);
                whereClause.append(AND_OPERATOR);
                whereClause.append(SPACE_CHAR);
            }
        }
        return whereClause.toString();
    }

    /**
     * Creates an SQL Select Statement to be used for further execution.
     *
     * @param selectMap A map containing all the values of each condition to be
     * met and their respective fields to be applied on.
     * @return A SQL Select Statement string with the adequate format and ready
     * to be filled.
     * @throws SQLException If the method {@link #getTableFields()} does not run
     * correctly. See {@link #makeWhereClause(LinkedHashMap)}.
     * @throws ResultExceptionPSDB If the field to be selected is not contained
     * in the table. See {@link #makeWhereClause(LinkedHashMap)}.
     */
    private String getSelectStatement(LinkedHashMap<String, Object> selectMap) throws SQLException, ResultExceptionPSDB {
        statementBuilder = new StringBuilder();
        statementBuilder.append(action.getAction());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(EVERYTHING_CHAR);
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.FROM.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(table.getTable());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.WHERE.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(makeWhereClause(selectMap));
        return statementBuilder.toString();
    }

    /**
     * Executes a SQL Select Statement from the predefined table.
     *
     * @param selectMap A map containing all the values of each condition and
     * their respective fields to be applied on.
     * @return A list that provides different maps containing all the values
     * returned by the SQL Select Statement.
     * @throws SQLException If the statement is not able to be executed.
     * @throws ResultExceptionPSDB If the method
     * {@link #getSelectStatement(LinkedHashMap<String, Object>)} does not run
     * correctly.
     */
    public ArrayList<LinkedHashMap<String, Object>> executeSelect(LinkedHashMap<String, Object> selectMap) throws SQLException, ResultExceptionPSDB {
        LinkedHashMap<String, String> typesMap = getTableTypes();
        String statement = getSelectStatement(selectMap);
        preparedStatement = connection.prepareStatement(statement);
        preparedStatement = setPreparedStatementArguments(preparedStatement, selectMap, typesMap);
        ResultSet resultSet = preparedStatement.executeQuery();
        ArrayList<LinkedHashMap<String, Object>> resultList = getResultMapWithWhereClause(resultSet, typesMap);
        return resultList;
    }

    /**
     * Creates an SQL Select Statement to be used for further execution.
     *
     * @return A SQL Select Statement string with the adequate format and ready
     * to be filled.
     * @throws SQLException If the method {@link #getTableFields()} does not run
     * correctly. See {@link #makeWhereClause(LinkedHashMap)}.
     * @throws ResultExceptionPSDB If the field to be selected is not contained
     * in the table. See {@link #makeWhereClause(LinkedHashMap)}.
     */
    private String getSelectAllStatement() throws SQLException, ResultExceptionPSDB {
        statementBuilder = new StringBuilder();
        statementBuilder.append(action.getAction());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(EVERYTHING_CHAR);
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.FROM.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(table.getTable());
        return statementBuilder.toString();
    }

    /**
     * Executes a SQL Select Statement from the predefined table.
     *
     * @return A list that provides all the elements from the given table.
     * @throws SQLException If the statement is not able to be executed.
     * @throws ResultExceptionPSDB If the method
     * {@link #getSelectStatement(LinkedHashMap<String, Object>)} does not run
     * correctly.
     */
    public ArrayList<LinkedHashMap<String, Object>> executeSelectAll() throws SQLException, ResultExceptionPSDB {
        LinkedHashMap<String, String> typesMap = getTableTypes();
        String statement = getSelectAllStatement();
        preparedStatement = connection.prepareStatement(statement);
        ResultSet resultSet = preparedStatement.executeQuery();
        ArrayList<LinkedHashMap<String, Object>> resultList = getResultMapWithWhereClause(resultSet, typesMap);
        return resultList;
    }

    /**
     * Creates a {@code UPDATE} clause with defined conditions to update the
     * selected fields.
     *
     * @param updateMap A map containing all the values of the updated data and
     * their respective fields to be updated on.
     * @return A {@code UPDATE} clause in a string format to be appended into a
     * full SQL Select Statement.
     * @throws SQLException If the method {@link #getTableFields()} does not run
     * correctly.
     * @throws ResultExceptionPSDB If the field to be updated is not contained
     * in the table.
     */
    private String makeUpdateClause(LinkedHashMap<String, Object> updateMap) throws SQLException, ResultExceptionPSDB {
        int index = 0;
        StringBuilder updateClause = new StringBuilder();
        LinkedHashSet<String> fieldsSet = getTableFields();
        for (String inputField : updateMap.keySet()) {
            if (!fieldsSet.contains(inputField)) {
                throw new ResultExceptionPSDB(ExceptionMessagesPSDB.UPDATE_NOFIELD, updateMap);
            }
            updateClause.append(inputField);
            updateClause.append(SPACE_CHAR);
            updateClause.append(EQUAL_CHAR);
            updateClause.append(SPACE_CHAR);
            updateClause.append(QUESTION_CHAR);
            index++;
            if (index != updateMap.size()) {
                updateClause.append(COMMA_CHAR);
                updateClause.append(SPACE_CHAR);
            }
        }
        return updateClause.toString();
    }

    /**
     * Creates an SQL Update Statement to be used for further execution.
     *
     * @param updateMap A map containing all the values of each field to be
     * updated and their respective fields to be applied on.
     * @param selectMap A map containing all the values of each condition to be
     * met and their respective fields to be applied on.
     * @return A SQL Update Statement string with the adequate format and ready
     * to be filled.
     * @throws SQLException If the method {@link #getTableFields()} does not run
     * correctly. See {@link #makeWhereClause(LinkedHashMap)} and
     * {@link #makeUpdateClause(LinkedHashMap<String, Object>)}.
     * @throws ResultExceptionPSDB If the field to be updated is not contained
     * in the table. See {@link #makeWhereClause(LinkedHashMap)} and
     * {@link #makeUpdateClause(LinkedHashMap<String, Object>)}.
     */
    private String getUpdateStatement(LinkedHashMap<String, Object> updateMap, LinkedHashMap<String, Object> selectMap) throws SQLException, ResultExceptionPSDB {
        statementBuilder = new StringBuilder();
        statementBuilder.append(action.getAction());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(table.getTable());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.SET.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(makeUpdateClause(updateMap));
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.WHERE.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(makeWhereClause(selectMap));
        return statementBuilder.toString();
    }

    /**
     * Executes a SQL Update Statement from the predefined table.
     *
     * @param updateMap A map containing all the values of each field to be
     * updated and their respective fields to be applied on.
     * @param selectMap A map containing all the values of each condition and
     * their respective fields to be applied on.
     * @throws SQLException If the statement is not able to be executed.
     * @throws ResultExceptionPSDB If the method
     * {@link #getUpdateStatement(LinkedHashMap<String, Object>,
     * LinkedHashMap<String, Object>)} does not run correctly.
     */
    public void executeUpdate(LinkedHashMap<String, Object> updateMap, LinkedHashMap<String, Object> selectMap) throws SQLException, ResultExceptionPSDB {
        LinkedHashMap<String, String> typesMap = getTableTypes();
        String statement = getUpdateStatement(updateMap, selectMap);
        preparedStatement = connection.prepareStatement(statement);
        preparedStatement = setPreparedStatementArguments(preparedStatement, updateMap, selectMap, typesMap);
        preparedStatement.executeUpdate();
    }

    /**
     * Creates an SQL Delete Statement to be used for further execution.
     *
     * @param deleteMap A map containing all the values of each condition and
     * their respective fields to be considered for applying a deletion.
     * @return A SQL Delete Statement string with the adequate format and ready
     * to be filled.
     * @throws SQLException If the method {@link #getTableFields()} does not run
     * correctly. See {@link #makeWhereClause(LinkedHashMap)} and
     * {@link #makeUpdateClause(LinkedHashMap<String, Object>)}.
     * @throws ResultExceptionPSDB If the field to be updated is not contained
     * in the table. See {@link #makeWhereClause(LinkedHashMap)} and
     * {@link #makeUpdateClause(LinkedHashMap<String, Object>)}.
     */
    private String getDeleteStatement(LinkedHashMap<String, Object> deleteMap) throws SQLException, ResultExceptionPSDB {
        statementBuilder = new StringBuilder();
        statementBuilder.append(action.getAction());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.FROM.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(table.getTable());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(ReservedPSDB.WHERE.getKeyword());
        statementBuilder.append(SPACE_CHAR);
        statementBuilder.append(makeWhereClause(deleteMap));
        return statementBuilder.toString();
    }

    /**
     * Executes a SQL Delete Statement from the predefined table.
     *
     * @param deleteMap A map containing all the values of each condition and
     * their respective fields to be considered for applying a deletion.
     * @throws SQLException If the statement is not able to be executed.
     * @throws ResultExceptionPSDB If the method
     * {@link #getDeleteStatement(LinkedHashMap<String, Object>)} does not run
     * correctly.
     */
    public void executeDelete(LinkedHashMap<String, Object> deleteMap) throws SQLException, ResultExceptionPSDB {
        LinkedHashMap<String, String> typesMap = getTableTypes();
        String statement = getDeleteStatement(deleteMap);
        preparedStatement = connection.prepareStatement(statement);
        preparedStatement = setPreparedStatementArguments(preparedStatement, deleteMap, typesMap);
        preparedStatement.executeUpdate();
    }
}
