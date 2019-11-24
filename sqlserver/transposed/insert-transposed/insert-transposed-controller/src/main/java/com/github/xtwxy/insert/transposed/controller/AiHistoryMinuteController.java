package com.github.xtwxy.insert.transposed.controller;

import com.github.apuex.springbootsolution.runtime.*;
import static com.github.apuex.springbootsolution.runtime.DateFormat.*;
import com.github.xtwxy.insert.transposed.message.*;
import com.github.xtwxy.insert.transposed.service.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.*;
import java.net.*;
import java.io.*;
import java.util.*;

@RestController
@RequestMapping(value="ai-history-minute", method=RequestMethod.POST)
public class AiHistoryMinuteController {
  @Autowired
  private AiHistoryMinuteService service;

  @RequestMapping(value="create-ai-history-minute", produces="application/json")
  public void create(@RequestBody CreateAiHistoryMinuteCmd c, HttpServletRequest r) throws URISyntaxException {
    service.create(c, r.getUserPrincipal(), new URI(r.getRequestURI()));
  }

  @RequestMapping(value="retrieve-ai-history-minute-by-rowid", produces="application/json")
  public AiHistoryMinuteVo retrieveByRowid(@RequestBody RetrieveByRowidCmd c, HttpServletRequest r) throws URISyntaxException {
    return service.retrieveByRowid(c, r.getUserPrincipal(), new URI(r.getRequestURI()));
  }
  
  @RequestMapping(value="retrieve-ai-history-minute", produces="application/json")
  public AiHistoryMinuteVo retrieve(@RequestBody RetrieveAiHistoryMinuteCmd c, HttpServletRequest r) throws URISyntaxException {
    return service.retrieve(c, r.getUserPrincipal(), new URI(r.getRequestURI()));
  }
  
  @RequestMapping(value="update-ai-history-minute", produces="application/json")
  public void update(@RequestBody UpdateAiHistoryMinuteCmd c, HttpServletRequest r) throws URISyntaxException {
    service.update(c, r.getUserPrincipal(), new URI(r.getRequestURI()));
  }

  @RequestMapping(value="delete-ai-history-minute", produces="application/json")
  public void delete(@RequestBody DeleteAiHistoryMinuteCmd c, HttpServletRequest r) throws URISyntaxException {
    service.delete(c, r.getUserPrincipal(), new URI(r.getRequestURI()));
  }

  @RequestMapping(value="query-ai-history-minute", produces="application/json")
  public AiHistoryMinuteListVo query(@RequestBody QueryCommand q, HttpServletRequest r) throws URISyntaxException {
    return service.query(q, r.getUserPrincipal(), new URI(r.getRequestURI()));
  }

  @RequestMapping(value="export-ai-history-minute", consumes="application/json")
  public void export(@RequestBody QueryCommand q, HttpServletRequest request, HttpServletResponse response) throws URISyntaxException, IOException {
    final AiHistoryMinuteListVo listVo = service.query(q, request.getUserPrincipal(), new URI(request.getRequestURI()));
    HSSFWorkbook wb = new HSSFWorkbook();
    HSSFSheet sheet = wb.createSheet("AiHistoryMinute");

    HSSFCellStyle style = wb.createCellStyle();
    style.setFillBackgroundColor(HSSFColor.HSSFColorPredefined.AQUA.getIndex());
    style.setFillPattern(FillPatternType.BIG_SPOTS);

    style = wb.createCellStyle();
    style.setFillForegroundColor(HSSFColor.HSSFColorPredefined.ORANGE.getIndex());
    style.setFillPattern(FillPatternType.SOLID_FOREGROUND);

    short rowNumber = 0;
    exportHeaderCells(sheet.createRow(rowNumber++), style);
    for(AiHistoryMinuteVo vo: listVo.getItemsList()) {
      HSSFRow row = sheet.createRow(rowNumber++);
      exportDataCells(vo, row, style);
    }

    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-disposition",String.format("attachment; filename=%sList-%s.xls", "AiHistoryMinute", formatTimestamp(new Date())));
    wb.write(response.getOutputStream());
  }

  private void exportHeaderCells(HSSFRow row, HSSFCellStyle style) {
    short colNumber = 0;
    HSSFCell cell = null;
    cell = row.createCell(colNumber++);
    cell.setCellValue("BatteryId");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("RecordTime");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("BatteryCurrent");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage4");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage5");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage6");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage7");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage8");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage9");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage10");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage11");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage12");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage13");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage14");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage15");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage16");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage17");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage18");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage19");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage20");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage21");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage22");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage23");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage24");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage25");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage26");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage27");
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue("Voltage28");
    cell.setCellStyle(style);
  }

  private void exportDataCells(AiHistoryMinuteVo vo, HSSFRow row, HSSFCellStyle style) {
    short colNumber = 0;
    HSSFCell cell = null;
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getBatteryId()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", formatTimestamp(vo.getRecordTime())));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getBatteryCurrent()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage4()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage5()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage6()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage7()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage8()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage9()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage10()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage11()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage12()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage13()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage14()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage15()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage16()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage17()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage18()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage19()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage20()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage21()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage22()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage23()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage24()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage25()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage26()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage27()));
    cell.setCellStyle(style);
    cell = row.createCell(colNumber++);
    cell.setCellValue(String.format("%s", vo.getVoltage28()));
    cell.setCellStyle(style);
  }
}
