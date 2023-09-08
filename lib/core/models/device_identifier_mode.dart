class DeviceIdentityResponse {
  DeviceIdentityResponse({
    this.systemName,
    this.isPhysicalDevice,
    this.utsname,
    this.id,
    this.model,
    this.localizedModel,
    this.systemVersion,
    this.manufacturer,
    this.name,
    this.identifierForVendor,
  });

  DeviceIdentityResponse.fromJson(Map<String, dynamic> json) {
    systemName = json['systemName'] as String?;
    id = json['id'] as dynamic;
    manufacturer = json['manufacturer'] as String?;
    isPhysicalDevice = json['isPhysicalDevice'] as dynamic;
    utsname = json['utsname'] != null
        ? Utsname.fromJson(json['utsname'] as Map<dynamic, dynamic>)
        : null;
    model = json['model'] as String?;
    localizedModel = json['localizedModel'] as dynamic;
    systemVersion = json['systemVersion'] as dynamic;
    name = json['name'] as String?;
    identifierForVendor = json['identifierForVendor'] as dynamic;
  }
  dynamic systemName;
  dynamic isPhysicalDevice;
  Utsname? utsname;
  dynamic model;
  dynamic localizedModel;
  dynamic systemVersion;
  dynamic name;
  dynamic identifierForVendor;
  dynamic manufacturer;
  dynamic id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['systemName'] = systemName;
    data['id'] = id;
    data['isPhysicalDevice'] = isPhysicalDevice;
    if (utsname != null) {
      data['utsname'] = utsname!.toJson();
    }
    data['model'] = model;
    data['manufacturer'] = manufacturer;
    data['localizedModel'] = localizedModel;
    data['systemVersion'] = systemVersion;
    data['name'] = name;
    data['identifierForVendor'] = identifierForVendor;
    return data;
  }
}

class Utsname {
  Utsname({
    this.release,
    this.sysname,
    this.nodename,
    this.machine,
    this.version,
  });

  Utsname.fromJson(Map<dynamic, dynamic> json) {
    release = json['release'] as dynamic;
    sysname = json['sysname'] as dynamic;
    nodename = json['nodename'] as dynamic;
    machine = json['machine'] as dynamic;
    version = json['version'] as dynamic;
  }
  dynamic release;
  dynamic sysname;
  dynamic nodename;
  dynamic machine;
  dynamic version;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['release'] = release;
    data['sysname'] = sysname;
    data['nodename'] = nodename;
    data['machine'] = machine;
    data['version'] = version;
    return data;
  }
}
