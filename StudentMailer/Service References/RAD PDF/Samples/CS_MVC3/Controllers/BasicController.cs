using System;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

using RadPdf.Web.UI;

namespace CS_MVC3.Controllers
{
    public class BasicController : Controller
    {
        //
        // GET: /PdfWebControl/

        public ActionResult Index()
        {
            // Get PDF as byte array from file (or database, browser upload, remote storage, etc)
            byte[] pdfData = System.IO.File.ReadAllBytes(Server.MapPath("~/Data/RadPdfSampleForm.pdf"));

            // Create RAD PDF control
            PdfWebControl pdfWebControl1 = new PdfWebControl();

            // Assign ID to control (important if Client API is to be used)
            pdfWebControl1.ID = "PdfWebControl1";

            // Create document from PDF data
            pdfWebControl1.CreateDocument("Document Name", pdfData);

            // Put control in ViewBag
            ViewBag.PdfWebControl1 = pdfWebControl1;

            return View();
        }

    }
}
