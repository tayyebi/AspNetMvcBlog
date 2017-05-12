using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nature.Controllers
{
    public class HomeController : Controller
    {
        DcDataContext dc = new DcDataContext();
        public ActionResult Index()
        {
            ViewBag.Message = "صفحه خانه" + "<a href=\"/Authorize/Login\">ورود به پنل مدیریت</a>";
            return View(dc.v_Groups.ToList());
        }
        public ActionResult Group(Guid id)
        {
            return View(dc.v_Posts.Where(m=>m.GroupId==id).OrderByDescending(x=>x.Id).Take(30));
        }
        public ActionResult Post(int? id)
        {
            if (id != null && id!=0)
            {
                var post = dc.v_Post(id).FirstOrDefault();
                ViewBag.PostBody = post.Body;
                ViewBag.Title = ViewBag.PostTitle = post.Title;
                ViewBag.PostAuthor = post.User;
                ViewBag.PostGroup = post.Group;
                ViewBag.PostDate = post.DateTime;
                return View();
            }
            return HttpNotFound();
        }
    }
}