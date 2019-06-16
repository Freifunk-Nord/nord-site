codes = true
std = "lua51"
self = false

ignore = {
	"111", -- setting non-standard global variable xyx
	"112", -- mutating non-standard global variable xyz
	"113", -- accessing undefined variable xyz
	"121", -- setting read-only global variable table
	"122", -- setting read-only field ? of global xyz
	"142", -- setting undefined field optional of global table
	"143", -- accessing undefined field value of global table
	"211", -- unused variable xyz
	"212", -- unused argument xyz
	"213", -- unused loop variable xyz
	"231", -- variable value is never accessed
	"311", -- value assigned to variable xyz is unused
	"321", -- accessing uninitialized variable
	"331", -- value assigned to variable xyz is mutated but never accessed
	"411", -- variable xyz was previously defined
	"412", -- variable xyz was previously defined as an argument
	"421", -- shadowing definition of variable xyz
	"422", -- shadowing definition of argument
	"423", -- shadowing definition of loop variable
	"431", -- shadowing upvalue xyz
	"432", -- shadowing upvalue argument xyz
	"511", -- unreachable code
	"512", -- loop is executed at most once
	"531", -- right side of assignment has more values than left side expects
	"542", -- empty if branch
	"611", -- line contains only whitespace
	"612", -- line contains trailing whitespace
	"614", -- trailing whitespace in a comment
	"621", -- inconsistent indentation (SPACE followed by TAB)
	"631", -- line is too long (> 120)
}

include_files = {
	"**/*.lua",
	"package/**/files/lib/gluon/ebtables/*",
	"package/**/luasrc/**/*",
}

-- files["scripts/check_site.lua"] = {
--	allow_defined = true,
--	module = true,
-- }

files["**/check_site.lua"] = {
	globals = {
		"alternatives",
		"extend",
		"in_domain",
		"in_site",
		"need",
		"need_alphanumeric_key",
		"need_array",
		"need_array_of",
		"need_boolean",
		"need_chanlist",
		"need_domain_name",
		"need_number",
		"need_one_of",
		"need_string",
		"need_string_array",
		"need_string_array_match",
		"need_string_match",
		"need_table",
		"need_value",
		"obsolete",
		"table_keys",
		"this_domain",
	},
}

files["package/**/files/lib/gluon/ebtables/*"] = {
	globals = {
		"site",
	},
	new_read_globals = {
		"chain",
		"rule",
	},
	max_line_length = false,
}

files["package/**/luasrc/lib/gluon/config-mode/*"] = {
	globals = {
		"DynamicList",
		"Flag",
		"Form",
		"i18n",
		"ListValue",
		"renderer.render",
		"renderer.render_string",
		"Section",
		"TextValue",
		"_translate",
		"translate",
		"translatef",
		"Value",
	},
}

files["package/**/luasrc/lib/gluon/**/controller/*"] = {
	new_read_globals = {
		"_",
		"alias",
		"call",
		"entry",
		"model",
		"node",
		"template",
	},
}

files["package/gluon-client-bridge/luasrc/usr/lib/lua/gluon/client_bridge.lua"] = {
	globals = {
		"next_node_macaddr",
	},
}

files["package/gluon-config-mode-geo-location-osm/luasrc/usr/lib/lua/gluon/config-mode/geo-location-osm.lua"] = {
--	allow_defined = true,
--	module = true,
	globals = {
		"help",
		"MapValue",
		"options",
	},
}

files["package/gluon-core/luasrc/usr/lib/lua/gluon/*"] = {
	globals = {
		"_M",
	},
}

files["package/gluon-core/luasrc/usr/lib/lua/gluon/iputil.lua"] = {
--	allow_defined = true,
--	module = true,
	globals = {
		"IPv6",
		"mac_to_ip",
	},
}

files["package/gluon-core/luasrc/usr/lib/lua/gluon/platform.lua"] = {
--	allow_defined = true,
--	module = true,
	globals = {
		"is_outdoor_device",
		"match",
	},
	new_read_globals = {
		-- globals provided by platform_info
		"get_board_name",
		"get_image_name",
		"get_model",
		"get_subtarget",
		"get_target",
	},
}

files["package/gluon-core/luasrc/usr/lib/lua/gluon/users.lua"] = {
	globals = {
		"remove_group",
		"remove_user",
	},
}

files["package/gluon-core/luasrc/usr/lib/lua/gluon/util.lua"] = {
--	allow_defined = true,
--	module = true,
	globals = {
		"add_to_set",
		"contains",
		"default_hostname",
		"domain_seed_bytes",
		"exec",
		"find_phy",
		"foreach_radio",
		"generate_mac",
		"get_mesh_devices",
		"get_uptime",
		"get_wlan_mac",
		"glob",
		"node_id",
		"readfile",
		"remove_from_set",
		"replace_prefix",
		"trim",
	},
}

files["package/gluon-web/luasrc/usr/lib/lua/gluon/web/*"] = {
	globals = {
		"Http",
		"HTTP_MAX_CONTENT",
		"mimedecode_message_body",
		"parse_message_body",
		"urldecode",
		"urldecode_params",
		"urlencode",
	},
}

files["package/gluon-web/luasrc/usr/lib/lua/gluon/web/util.lua"] = {
	globals = {
		"class",
		"instanceof",
		"pcdata",
	},
}

files["package/gluon-web-admin/luasrc/lib/gluon/config-mode/controller/admin/upgrade.lua"] = {
	globals = {
		"file",
	},
}

files["package/gluon-web-mesh-vpn-fastd/luasrc/lib/gluon/config-mode/model/admin/mesh_vpn_fastd.lua"] = {
	globals = {
		"gluon",
	},
}

files["package/gluon-web-model/luasrc/usr/lib/lua/gluon/web/model/datatypes.lua"] = {
--	allow_defined = true,
--	module = true,
	globals = {
		"bool",
		"float",
		"imax",
		"imin",
		"integer",
		"ip4addr",
		"ip6addr",
		"ipaddr",
		"irange",
		"max",
		"maxlength",
		"min",
		"minlength",
		"range",
		"ufloat",
		"uinteger",
		"wpakey",
	},
}

files["package/gluon-web-model/luasrc/usr/lib/lua/gluon/web/model/classes.lua"] = {
--	allow_defined = true,
	globals = {
		"AbstractValue",
		"DynamicList",
		"Flag",
		"Form",
		"FORM_INVALID",
		"FORM_NODATA",
		"FORM_VALID",
		"ListValue",
		"Node",
		"Section",
		"Template",
		"TextValue",
		"Value",
	},
}

files["package/gluon-web-osm/luasrc/usr/lib/lua/gluon/*"] = {
	globals = {
		"MapValue",
	},
}
