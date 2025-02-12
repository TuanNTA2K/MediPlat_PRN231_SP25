﻿using MediPlat.Model.Authen_Athor;
using MediPlat.Service.IServices;
using Microsoft.AspNetCore.Mvc;

namespace MediPlat.API.Controllers
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;
        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginModel loginModel)
        {
            if (loginModel == null)
            {
                throw new ArgumentNullException(nameof(loginModel));
            }

            var login = _authService.Login(loginModel);
            if (string.IsNullOrEmpty(login.Token))
            {
                return Unauthorized(new { Message = "Invalid credentials" });
            }

            return Ok(login);
        }
    }
}
