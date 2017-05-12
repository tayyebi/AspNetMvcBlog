using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nature.Controllers
{
    public class AuthorizeController : Controller
    {
        DcDataContext dc = new DcDataContext();

        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string Username, string Password)
        {
            if (Convert.ToBoolean(dc.v_Check_Password(Username, Password)))
            {
                Session["Username"] = Username;
                return RedirectToRoute(new { controller = "Private", action = "Index" });
            }
            else
            {
                ViewBag.Message = "نام کاربری یا کلمه عبور اشتباه است";
                return View();
            }

        }
        [Authenticate]
        public ActionResult Logout()
        {
            Session["Username"] = null;
            return RedirectToAction("Login");
        }
    }
}