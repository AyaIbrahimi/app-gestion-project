package com.dxc.dxc_platform.dto;

import java.util.List;

public class UserStatusReportDto {
    private List<UserReportDto> users;
    private long totalActive;
    private long totalInactive;
    private long totalLocked;
    // Utilisateur qui réinitialise le plus souvent son mot de passe
    private UserReportDto topPasswordResetter;
    private int maxPasswordResetCount;

    public UserStatusReportDto() {}

    public UserStatusReportDto(List<UserReportDto> users, long totalActive, long totalInactive,
                               long totalLocked, UserReportDto topPasswordResetter,
                               int maxPasswordResetCount) {
        this.users = users;
        this.totalActive = totalActive;
        this.totalInactive = totalInactive;
        this.totalLocked = totalLocked;
        this.topPasswordResetter = topPasswordResetter;
        this.maxPasswordResetCount = maxPasswordResetCount;
    }

    // Getters & Setters
    public List<UserReportDto> getUsers() { return users; }
    public void setUsers(List<UserReportDto> users) { this.users = users; }

    public long getTotalActive() { return totalActive; }
    public void setTotalActive(long totalActive) { this.totalActive = totalActive; }

    public long getTotalInactive() { return totalInactive; }
    public void setTotalInactive(long totalInactive) { this.totalInactive = totalInactive; }

    public long getTotalLocked() { return totalLocked; }
    public void setTotalLocked(long totalLocked) { this.totalLocked = totalLocked; }

    public UserReportDto getTopPasswordResetter() { return topPasswordResetter; }
    public void setTopPasswordResetter(UserReportDto topPasswordResetter) { this.topPasswordResetter = topPasswordResetter; }

    public int getMaxPasswordResetCount() { return maxPasswordResetCount; }
    public void setMaxPasswordResetCount(int maxPasswordResetCount) { this.maxPasswordResetCount = maxPasswordResetCount; }
}