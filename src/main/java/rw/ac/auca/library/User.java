package rw.ac.auca.library;
public class User extends person {
    private String role;
    private String membership;
    private String hashedPassword;

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getMembership() { return membership; }
    public void setMembership(String membership) { this.membership = membership; }
    public String getHashedPassword() { return hashedPassword; }
    public void setHashedPassword(String hashedPassword) { this.hashedPassword = hashedPassword; }
}
