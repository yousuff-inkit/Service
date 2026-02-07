package com.procurement.purchase.purchaseintent;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.BufferedReader;
import java.io.FileReader;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.DataFormatter;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClspurchaseintentExcelImport {
    ClsConnection connDAO = new ClsConnection();
    ClsCommon commonDAO = new ClsCommon();

    public int ExcelImport(String docNo) throws SQLException {
        Connection conn = null;

        try {
            conn = connDAO.getMyConnection();
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();

            String path = "";
            String sql = "select path from my_fileattach where doc_no='" + docNo + "' and dtype='PI'";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                path = rs.getString("path");
            }
            path = path.replace("\\", "//");

            java.sql.PreparedStatement pstm = null;
            FileInputStream input = new FileInputStream(path);
            POIFSFileSystem fs = new POIFSFileSystem(input);
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();

            Row row;
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                row = sheet.getRow(i);

                String partNo = formatter.formatCellValue(row.getCell(1)).trim();
                String productName = formatter.formatCellValue(row.getCell(2)).trim();
                String description = formatter.formatCellValue(row.getCell(3)).trim();
                Double qty = formatter.formatCellValue(row.getCell(5)).trim() == "" ? 0
                        : Double.parseDouble(formatter.formatCellValue(row.getCell(5)).trim());
                Double unitPrice = formatter.formatCellValue(row.getCell(6)).trim() == "" ? 0
                        : Double.parseDouble(formatter.formatCellValue(row.getCell(6)).trim());
                Double discPerc = formatter.formatCellValue(row.getCell(8)).trim() == "" ? 0
                        : Double.parseDouble(formatter.formatCellValue(row.getCell(8)).trim());
                Double discAmt = formatter.formatCellValue(row.getCell(9)).trim() == "" ? 0
                        : Double.parseDouble(formatter.formatCellValue(row.getCell(9)).trim());

                Double total = qty * unitPrice;

                String sql2 = "INSERT INTO my_pod_excel (part_no, product_name, description, qty, unit_price, total, disc_perc, disc_amt, id) "
                        + "VALUES ('" + partNo + "', '" + productName + "', '" + description + "', " + qty + ", "
                        + unitPrice + ", " + total + ", " + discPerc + ", " + discAmt + ", " + docNo + ");";
                pstm = conn.prepareStatement(sql2);
                pstm.execute();
            }

            conn.commit();
            pstm.close();
            conn.close();
            input.close();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            return 0;
        } finally {
            conn.close();
        }
    }

    public int ExcelImportCSV(String docNo) throws SQLException {
        Connection conn = null;

        try {
            conn = connDAO.getMyConnection();
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();
            java.sql.PreparedStatement pstm = null;

            String path = "";
            String line = "";
            String cvsSplitBy = ",";

            String sql = "select path from my_fileattach where doc_no='" + docNo + "' and dtype='PI'";

            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                path = rs.getString("path");
            }
            path = path.replace("\\", "//");

            BufferedReader br = new BufferedReader(new FileReader(path));

            int i = 0;

            while ((line = br.readLine()) != null) {
                if (i > 0) {
                    // use comma as separator
                    String[] data = line.split(cvsSplitBy);

                    String partNo = data[1].trim();
                    String productName = data[2].trim();
                    String description = data[3].trim();
                    Double qty = data[5] == "" ? 0 : Double.parseDouble(data[5].trim());
                    Double unitPrice = data[6] == "" ? 0 : Double.parseDouble(data[6].trim());
                    Double discPerc = 0.0;
                    Double discAmt = 0.0;

                    if (8 < data.length) {
                        discPerc = data[8] == "" ? 0 : Double.parseDouble(data[8].trim());
                    }
                    if (9 < data.length) {
                        discAmt = data[9] == "" ? 0 : Double.parseDouble(data[9].trim());
                    }

                    Double total = qty * unitPrice;

                    String sql2 = "INSERT INTO my_pod_excel (part_no, product_name, description, qty, unit_price, total, disc_perc, disc_amt, id) "
                            + "VALUES ('" + partNo + "', '" + productName + "', '" + description + "', " + qty + ", "
                            + unitPrice + ", " + total + ", " + discPerc + ", " + discAmt + ", " + docNo + ");";
                    pstm = conn.prepareStatement(sql2);
                    pstm.execute();
                }
                i++;
            }

            conn.commit();
            pstm.close();
            conn.close();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            return 0;
        } finally {
            conn.close();
        }
    }

}
