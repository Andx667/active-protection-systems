class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class PREFIX {
                displayName = ECSTRING(main,displayName);
                collapsed = 1;
                class Attributes {
                    class GVAR(enabled) {
                        displayName = CSTRING(Attribute_Enabled_DisplayName);
                        tooltip = CSTRING(Attribute_Enabled_Tooltip);
                        property = QGVAR(enabled);
                        control = "Checkbox";
                        // Expression only runs on the server, so the variable is public
                        expression = QUOTE(if (!_value) then {_this setVariable [ARR_3(QQGVAR(enabled),false,true)]});
                        defaultValue = "true";
                        condition = "objectVehicle";
                        typeName = "BOOL";
                    };
                };
            };
        };
    };
};
