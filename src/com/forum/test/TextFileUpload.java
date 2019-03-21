package  com.forum.test;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.forum.beans.User;
import com.forum.dao.impl.UserDaoImpl;
import com.forum.service.impl.TextServiceImpl;
import com.forum.service.impl.UserServiceImpl;

public class TextFileUpload extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user =(User) request.getSession().getAttribute("user");
		int id=user.getUserId();
		try {
			// 接受上传文件
			// 1.创建磁盘文件项工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2.创建文件上传的核心类
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 3.解析request-获得文件项集合
			List<FileItem> list = upload.parseRequest(request);
			// 4.遍历文件项集合
			for (FileItem item : list) {
				// 判断普通表单项/文件上传项
				boolean formField = item.isFormField();// 是否是一个普通表单项
				System.out.println(formField);
				if (formField) {
					request.setCharacterEncoding("utf-8");
					// 普通表单项
					String fieldName = item.getFieldName();
					String fieldValue = item.getString();
					System.out.println("这里是普通表单"+fieldName + "---" + fieldValue);
				} else {
					// 文件上传项
					// 获得上传文件的名称
					String fileName = item.getName();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
		Date date = new Date();
		String format = sdf.format(date);
		fileName=id+format+".jpg";
		
					// 获得上传文件的内容
					InputStream in = item.getInputStream();
					// 将in中的数据拷贝到服务器上
					String path = this.getServletContext().getRealPath("userImg");
					//地址斜杠方向和windos的方向不一样
					//图片地址
					
		String imgaddress=path+"/" + fileName;
		
		System.out.println(imgaddress);
					OutputStream out = new FileOutputStream(path+"/" + fileName);
					int len = 0;
					byte[] buffer = new byte[1024];
					while ((len = in.read(buffer)) > 0) {
						out.write(buffer, 0, len);
					}
					in.close();
					out.close();
					String xiangduiimg="userImg/"+fileName;
					
					System.out.println(xiangduiimg);		
					request.setAttribute("xiangduiimg", xiangduiimg );
				 request.getRequestDispatcher("NewText.jsp").forward(request, response);	
					
					
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		response.getWriter().write("hello Bonnie...");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}