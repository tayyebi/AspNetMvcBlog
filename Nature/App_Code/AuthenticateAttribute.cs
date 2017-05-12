using System;
using System.Web.Mvc;

namespace Nature.Controllers
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true)]

    class AuthenticateAttribute : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            bool CanAccess = false;
            try
            {
                filterContext.HttpContext.Session["Username"].ToString();
                CanAccess = true;
            }
            catch { }

            if (!CanAccess)
                filterContext.Result = new HttpStatusCodeResult(404);
        }
    }
}
