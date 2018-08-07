package com.sample.app;

import java.security.Principal;

public class RolePrincipal implements Principal {
    private final String groupName;
    public RolePrincipal(String groupName) {
        this.groupName = groupName;
    }

    @Override
    public String getName() {
        return groupName;
    }
}
