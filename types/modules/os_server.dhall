{ availability_zone : Optional Text
, image : Text
, image_exclude : Optional Text
, flavor_include : Optional Text
, meta : Optional (List Text)
, flavor : Optional Natural
, security_groups : Optional (List Text)
, scheduler_hints : Optional Text
, boot_from_volume : Optional Bool
, userdata : Optional Text
, network : Optional Text
, nics : Optional (List Text)
, floating_ips : Optional (List Text)
, flavor_ram : Optional Natural
, volume_size : Optional Text
, state : Optional Text
, auto_ip : Optional Text
, config_drive : Optional Text
, terminate_volume : Optional Bool
, key_name : Optional Text
, boot_volume : Optional Text
, wait : Optional Text
, name : Text
, timeout : Optional Natural
, delete_fip : Optional Bool
, volumes : Optional (List Text)
, floating_ip_pools : Optional Text
, reuse_ips : Optional Bool
}
