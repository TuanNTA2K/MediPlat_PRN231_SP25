﻿using MediPlat.Model.RequestObject;
using MediPlat.Model.ResponseObject;
using MediPlat.Service.IServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.OData.Routing.Controllers;
using System.Security.Claims;

namespace MediPlat.API.Controllers
{
    [Route("api/experience")]
    [ApiController]
    public class ExperienceController : ODataController
    {
        private readonly IExperienceService _experienceService;
        private readonly ILogger<ExperienceController> _logger;

        public ExperienceController(IExperienceService experienceService, ILogger<ExperienceController> logger)
        {
            _experienceService = experienceService;
            _logger = logger;
        }

        [HttpGet]
        [EnableQuery]
        [Authorize(Roles = "Doctor")]
        public IQueryable<ExperienceResponse> GetExperiences()
        {
            return _experienceService.GetAllExperiences();
        }

        [HttpGet("{id}")]
        [Authorize(Roles = "Doctor")]
        public async Task<IActionResult> GetExperience(Guid id)
        {
            var experience = await _experienceService.GetExperienceByIdAsync(id);
            return experience != null ? Ok(experience) : NotFound($"Experience với ID {id} không tồn tại.");
        }

        [HttpPost]
        [Authorize(Roles = "Doctor")]
        public async Task<IActionResult> CreateExperience([FromBody] ExperienceRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var doctorIdClaim = User.Claims.SingleOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            var response = await _experienceService.AddExperienceAsync(request);
            return CreatedAtAction(nameof(GetExperience), new { id = response.Id }, response);
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Doctor")]
        public async Task<IActionResult> UpdateExperience(Guid id, [FromBody] ExperienceRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var doctorIdClaim = User.Claims.SingleOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            var existingExperience = await _experienceService.GetExperienceByIdAsync(id);
            var response = await _experienceService.UpdateExperienceAsync(id, request);
            return Ok(response);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Doctor")]
        public async Task<IActionResult> DeleteExperience(Guid id)
        {
            var doctorIdClaim = User.Claims.SingleOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            var existingExperience = await _experienceService.GetExperienceByIdAsync(id);
            await _experienceService.DeleteExperienceAsync(id);
            return NoContent();
        }
    }
}
