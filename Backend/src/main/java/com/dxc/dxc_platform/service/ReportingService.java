package com.dxc.dxc_platform.service;

import com.dxc.dxc_platform.dto.*;
import java.util.List;

public interface ReportingService {

    List<ProjectReportDto> getProjectsReport(Integer year, String status, Long teamId);

    List<ProjectReportDto> getOverdueProjects();

    List<TaskReportDto> getOverdueTasks(Long projectId);

    List<UserReportDto> getUsersWithoutProfile();

    UserStatusReportDto getUsersByStatus(Boolean active);

    List<ProjectSelectDto> getProjectsForSelect();

    List<TeamSelectDto> getTeamsForSelect();
    List<ManagerProjectDto> getProjectsByManager();
}