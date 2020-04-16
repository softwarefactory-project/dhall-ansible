{ auto_floating_ip : Optional Bool
, auto_ip : Optional Bool
, availability_zone : Optional Text
, boot_from_volume : Optional Bool
, boot_volume : Optional Text
, config_drive : Optional Bool
, delete_fip : Optional Bool
, flavor : Optional Text
, flavor_include : Optional Text
, flavor_ram : Optional Text
, floating_ip_pools : Optional Text
, floating_ips : Optional (List Text)
, image : Text
, image_exclude : Optional Text
, key_name : Optional Text
, meta : Optional Text
, name : Text
, network : Optional Text
, nics : Optional Text
, public_ip : Optional Bool
, reuse_ips : Optional Bool
, root_volume : Optional Text
, scheduler_hints : Optional Text
, security_groups : Optional Text
, state : Optional Text
, terminate_volume : Optional Bool
, timeout : Optional Text
, userdata : Optional Text
, volume_size : Optional Text
, volumes : Optional Text
, wait : Optional Bool
}
