package com.github.xtwxy.insert.transposed.dao;

import com.github.apuex.springbootsolution.runtime.*;
import static com.github.apuex.springbootsolution.runtime.DateFormat.*;
import com.github.xtwxy.insert.transposed.message.*;
import com.github.apuex.springbootsolution.runtime.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.jdbc.core.*;
import org.springframework.stereotype.*;

import java.sql.*;
import java.util.*;

@Component
public class AiHistoryMinuteDAO {

  private final static Logger logger = LoggerFactory.getLogger(AiHistoryMinuteDAO.class);
  private final WhereClauseWithUnnamedParams where = new WhereClauseWithUnnamedParams(new CamelToCConverter());
  @Autowired
  private final JdbcTemplate jdbcTemplate;
  public static class ParamMapper implements QueryParamMapper {
    private final Map<String, TypeConverter> mappers;

    public ParamMapper() {
      Map<String, TypeConverter> map = new HashMap<>();
      map.put("batteryId", TypeConverters.toJavaTypeConverter("string"));
      map.put("recordTime", TypeConverters.toJavaTypeConverter("timestamp"));
      map.put("batteryCurrent", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage4", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage5", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage6", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage7", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage8", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage9", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage10", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage11", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage12", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage13", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage14", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage15", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage16", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage17", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage18", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage19", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage20", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage21", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage22", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage23", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage24", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage25", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage26", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage27", TypeConverters.toJavaTypeConverter("double"));
      map.put("voltage28", TypeConverters.toJavaTypeConverter("double"));
      this.mappers = map;
    }

    public Object map(String name, String value) {
      TypeConverter c = mappers.get(name);
      if(null == c) {
        logger.error("No such a field: {}", name);
      }
      return c.convert(value);
    }

    public boolean exists(String name) {
      return mappers.containsKey(name);
    }
  }
  private final QueryParamMapper paramMapper = new ParamMapper();
  public static class ResultRowMapper implements RowMapper<AiHistoryMinuteVo> {
    public AiHistoryMinuteVo mapRow(java.sql.ResultSet rs, int rowNum) throws SQLException {
      AiHistoryMinuteVo.Builder builder = AiHistoryMinuteVo.newBuilder();
      if(null != rs.getString("BatteryId")) builder.setBatteryId(rs.getString("BatteryId"));
      if(null != rs.getTimestamp("RecordTime")) builder.setRecordTime(toTimestamp(rs.getTimestamp("RecordTime")));
      builder.setBatteryCurrent(rs.getDouble("BatteryCurrent"));
      builder.setVoltage4(rs.getDouble("Voltage4"));
      builder.setVoltage5(rs.getDouble("Voltage5"));
      builder.setVoltage6(rs.getDouble("Voltage6"));
      builder.setVoltage7(rs.getDouble("Voltage7"));
      builder.setVoltage8(rs.getDouble("Voltage8"));
      builder.setVoltage9(rs.getDouble("Voltage9"));
      builder.setVoltage10(rs.getDouble("Voltage10"));
      builder.setVoltage11(rs.getDouble("Voltage11"));
      builder.setVoltage12(rs.getDouble("Voltage12"));
      builder.setVoltage13(rs.getDouble("Voltage13"));
      builder.setVoltage14(rs.getDouble("Voltage14"));
      builder.setVoltage15(rs.getDouble("Voltage15"));
      builder.setVoltage16(rs.getDouble("Voltage16"));
      builder.setVoltage17(rs.getDouble("Voltage17"));
      builder.setVoltage18(rs.getDouble("Voltage18"));
      builder.setVoltage19(rs.getDouble("Voltage19"));
      builder.setVoltage20(rs.getDouble("Voltage20"));
      builder.setVoltage21(rs.getDouble("Voltage21"));
      builder.setVoltage22(rs.getDouble("Voltage22"));
      builder.setVoltage23(rs.getDouble("Voltage23"));
      builder.setVoltage24(rs.getDouble("Voltage24"));
      builder.setVoltage25(rs.getDouble("Voltage25"));
      builder.setVoltage26(rs.getDouble("Voltage26"));
      builder.setVoltage27(rs.getDouble("Voltage27"));
      builder.setVoltage28(rs.getDouble("Voltage28"));

      return builder.build();
    }
  }
  private final RowMapper<AiHistoryMinuteVo> rowMapper = new ResultRowMapper();

  public AiHistoryMinuteDAO(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  public int create(CreateAiHistoryMinuteCmd c) {
    int rowsAffected = jdbcTemplate.update("UPDATE battery_system.ai_history_minute SET battery_id = ?, battery_current = ?, voltage_4 = ?, voltage_5 = ?, voltage_6 = ?, voltage_7 = ?, voltage_8 = ?, voltage_9 = ?, voltage_10 = ?, voltage_11 = ?, voltage_12 = ?, voltage_13 = ?, voltage_14 = ?, voltage_15 = ?, voltage_16 = ?, voltage_17 = ?, voltage_18 = ?, voltage_19 = ?, voltage_20 = ?, voltage_21 = ?, voltage_22 = ?, voltage_23 = ?, voltage_24 = ?, voltage_25 = ?, voltage_26 = ?, voltage_27 = ?, voltage_28 = ? WHERE record_time = ?", c.getBatteryId(), c.getBatteryCurrent(), c.getVoltage4(), c.getVoltage5(), c.getVoltage6(), c.getVoltage7(), c.getVoltage8(), c.getVoltage9(), c.getVoltage10(), c.getVoltage11(), c.getVoltage12(), c.getVoltage13(), c.getVoltage14(), c.getVoltage15(), c.getVoltage16(), c.getVoltage17(), c.getVoltage18(), c.getVoltage19(), c.getVoltage20(), c.getVoltage21(), c.getVoltage22(), c.getVoltage23(), c.getVoltage24(), c.getVoltage25(), c.getVoltage26(), c.getVoltage27(), c.getVoltage28(), toDate(c.getRecordTime()));
    if(rowsAffected > 0) {
      return rowsAffected;
    } else {
      return jdbcTemplate.update("INSERT INTO battery_system.ai_history_minute(battery_id,record_time,battery_current,voltage_4,voltage_5,voltage_6,voltage_7,voltage_8,voltage_9,voltage_10,voltage_11,voltage_12,voltage_13,voltage_14,voltage_15,voltage_16,voltage_17,voltage_18,voltage_19,voltage_20,voltage_21,voltage_22,voltage_23,voltage_24,voltage_25,voltage_26,voltage_27,voltage_28) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", c.getBatteryId(),toDate(c.getRecordTime()),c.getBatteryCurrent(),c.getVoltage4(),c.getVoltage5(),c.getVoltage6(),c.getVoltage7(),c.getVoltage8(),c.getVoltage9(),c.getVoltage10(),c.getVoltage11(),c.getVoltage12(),c.getVoltage13(),c.getVoltage14(),c.getVoltage15(),c.getVoltage16(),c.getVoltage17(),c.getVoltage18(),c.getVoltage19(),c.getVoltage20(),c.getVoltage21(),c.getVoltage22(),c.getVoltage23(),c.getVoltage24(),c.getVoltage25(),c.getVoltage26(),c.getVoltage27(),c.getVoltage28());
    }
  }

  public AiHistoryMinuteVo retrieveByRowid(RetrieveByRowidCmd c) {
    return (AiHistoryMinuteVo) jdbcTemplate.queryForObject("SELECT battery_id, record_time, battery_current, voltage_4, voltage_5, voltage_6, voltage_7, voltage_8, voltage_9, voltage_10, voltage_11, voltage_12, voltage_13, voltage_14, voltage_15, voltage_16, voltage_17, voltage_18, voltage_19, voltage_20, voltage_21, voltage_22, voltage_23, voltage_24, voltage_25, voltage_26, voltage_27, voltage_28 FROM battery_system.ai_history_minute WHERE rowid = ? ", rowMapper, c.getRowid());
  }

  public AiHistoryMinuteVo retrieve(RetrieveAiHistoryMinuteCmd c) {
    return (AiHistoryMinuteVo) jdbcTemplate.queryForObject("SELECT battery_id, record_time, battery_current, voltage_4, voltage_5, voltage_6, voltage_7, voltage_8, voltage_9, voltage_10, voltage_11, voltage_12, voltage_13, voltage_14, voltage_15, voltage_16, voltage_17, voltage_18, voltage_19, voltage_20, voltage_21, voltage_22, voltage_23, voltage_24, voltage_25, voltage_26, voltage_27, voltage_28 FROM battery_system.ai_history_minute WHERE record_time = ? ", rowMapper, toDate(c.getRecordTime()));
  }

  public int update(UpdateAiHistoryMinuteCmd c) {
    return jdbcTemplate.update("UPDATE battery_system.ai_history_minute SET battery_id = ?, battery_current = ?, voltage_4 = ?, voltage_5 = ?, voltage_6 = ?, voltage_7 = ?, voltage_8 = ?, voltage_9 = ?, voltage_10 = ?, voltage_11 = ?, voltage_12 = ?, voltage_13 = ?, voltage_14 = ?, voltage_15 = ?, voltage_16 = ?, voltage_17 = ?, voltage_18 = ?, voltage_19 = ?, voltage_20 = ?, voltage_21 = ?, voltage_22 = ?, voltage_23 = ?, voltage_24 = ?, voltage_25 = ?, voltage_26 = ?, voltage_27 = ?, voltage_28 = ? WHERE record_time = ?", c.getBatteryId(), c.getBatteryCurrent(), c.getVoltage4(), c.getVoltage5(), c.getVoltage6(), c.getVoltage7(), c.getVoltage8(), c.getVoltage9(), c.getVoltage10(), c.getVoltage11(), c.getVoltage12(), c.getVoltage13(), c.getVoltage14(), c.getVoltage15(), c.getVoltage16(), c.getVoltage17(), c.getVoltage18(), c.getVoltage19(), c.getVoltage20(), c.getVoltage21(), c.getVoltage22(), c.getVoltage23(), c.getVoltage24(), c.getVoltage25(), c.getVoltage26(), c.getVoltage27(), c.getVoltage28(), toDate(c.getRecordTime()));
  }

  public int delete(DeleteAiHistoryMinuteCmd c) {
    return jdbcTemplate.update("DELETE FROM battery_system.ai_history_minute WHERE record_time = ?", toDate(c.getRecordTime()));
  }

  public AiHistoryMinuteListVo query(QueryCommand q) {
    if(q.getPageNumber() > 0
      && q.getRowsPerPage() > 0
      && q.getOrderByCount() > 0) {
      if(!(q.getOrderByList().stream()
        .map(x -> paramMapper.exists(x.getFieldName()))
        .reduce((x, y) -> x && y)
        .get())) throw new RuntimeException("Invalid order by field.");
      String orderBy = q.getOrderByList().stream()
          .map(x -> String.format("%s %s", SymbolConverters.cToPascal().apply(x.getFieldName()), x.getOrder()))
          .reduce((x, y) -> String.format("%s, %s", x, y))
          .get();
      String sql = String.format("WITH Paginatedai_history_minute AS ("
          + "SELECT ROW_NUMBER() OVER (ORDER BY %s) AS RowNumber, "
          + "battery_id, record_time, battery_current, voltage_4, voltage_5, voltage_6, voltage_7, voltage_8, voltage_9, voltage_10, voltage_11, voltage_12, voltage_13, voltage_14, voltage_15, voltage_16, voltage_17, voltage_18, voltage_19, voltage_20, voltage_21, voltage_22, voltage_23, voltage_24, voltage_25, voltage_26, voltage_27, voltage_28 "
          + "FROM battery_system.ai_history_minute %s "
          + ")"
          + "SELECT battery_id, record_time, battery_current, voltage_4, voltage_5, voltage_6, voltage_7, voltage_8, voltage_9, voltage_10, voltage_11, voltage_12, voltage_13, voltage_14, voltage_15, voltage_16, voltage_17, voltage_18, voltage_19, voltage_20, voltage_21, voltage_22, voltage_23, voltage_24, voltage_25, voltage_26, voltage_27, voltage_28 "
          + "FROM Paginatedai_history_minute "
          + "WHERE RowNumber > ? AND RowNumber <= ?",
          orderBy,
          where.toWhereClause(q));
      List<Object> params = new LinkedList<>(where.toUnnamedParamList(q, paramMapper));
      Integer beginRow = Integer.valueOf((q.getPageNumber() == 0 ? 0 : (q.getPageNumber() - 1)) * q.getRowsPerPage());
      Integer endRow = Integer.valueOf(q.getPageNumber() * q.getRowsPerPage());
      List<Object> moreParams = new LinkedList<>(params);
      params.add(beginRow);
      params.add(endRow);
      moreParams.add(endRow);
      moreParams.add(endRow + 1);
      logger.info(sql);
      jdbcTemplate.query(sql, rowMapper, params.toArray());
      return AiHistoryMinuteListVo.newBuilder()
        .addAllItems(jdbcTemplate.query(sql, rowMapper, params.toArray()))
        .setHasMore(!(jdbcTemplate.query(sql, rowMapper, moreParams.toArray()).isEmpty()))
        .build();
    } else {
      String sql = String.format("SELECT battery_id, record_time, battery_current, voltage_4, voltage_5, voltage_6, voltage_7, voltage_8, voltage_9, voltage_10, voltage_11, voltage_12, voltage_13, voltage_14, voltage_15, voltage_16, voltage_17, voltage_18, voltage_19, voltage_20, voltage_21, voltage_22, voltage_23, voltage_24, voltage_25, voltage_26, voltage_27, voltage_28 FROM battery_system.ai_history_minute %s ", where.toWhereClause(q));
      logger.info(sql);
      return AiHistoryMinuteListVo.newBuilder()
        .addAllItems(jdbcTemplate.query(sql, rowMapper, where.toUnnamedParamList(q, paramMapper).toArray()))
        .build();
    }
  }

}
