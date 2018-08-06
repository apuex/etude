package com.github.apuex.protobuf.java;

import com.google.protobuf.Any;
import com.google.protobuf.DescriptorProtos;
import com.google.protobuf.Descriptors;
import com.google.protobuf.Message;
import com.google.protobuf.util.JsonFormat;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import static java.lang.System.out;

public class Main {
  public static String type(String typeUrl) {
    return typeUrl.split("/")[1];
  }

  public static void main(String[] args) throws Exception {
    JsonFormat.TypeRegistry registry = JsonFormat.TypeRegistry.newBuilder()
        .add(AnyTest.getDescriptor().getMessageTypes())
        .build();
    JsonFormat.Printer printer = JsonFormat.printer().usingTypeRegistry(registry);
    JsonFormat.Parser parser = JsonFormat.parser().usingTypeRegistry(registry);

    AnyTest.getDescriptor().getMessageTypes().stream()
        .forEach(m -> out.println(m.getName()));

    AnyTest.getDescriptor().getEnumTypes().stream()
        .forEach(m -> out.println(m.getFullName()));

    String json = printer.print(Any.pack(addressBook()));
    out.println(json);

    Any.Builder anyBuilder = Any.newBuilder();
    parser.merge(json, anyBuilder);
    Any any = anyBuilder.build();
    String packageName = AnyTest.getDescriptor().getOptions().getJavaPackage();
    out.println(any.getTypeUrl());
    Descriptors.Descriptor descriptor = registry.find(type(any.getTypeUrl()));
    Class<Message> clazz = (Class<Message>) Class.forName(String.format("%s.%s", packageName, descriptor.getName()));
    Message message = any.unpack(clazz);

    out.println(descriptor.getFullName());
    //Message message = descriptor.toProto().getDefaultInstanceForType()parseFrom(any.getValue());
    out.println(message.getClass().getName());

    loadDescriptors("target/generated-resources/protobuf/descriptor-sets/any.protobin")
        .forEach((k, v) -> out.printf("%s => %s\n", k, v));

    out.printf("load descriptors from %s: \n", AnyTest.class.getName());
    loadAnyTestDescriptors();
  }

  private static AddressBook addressBook() {
    return AddressBook.newBuilder()
        .setName("Wangxy")
        .addAllContacts(contactPerson())
        .build();
  }

  private static List<Person> contactPerson() {
    LinkedList<Person> list = new LinkedList();
    for (int i = 1; i < 3; ++i) {
      list.add(Person.newBuilder()
          .setName(String.format("Stink Bastard %s", Integer.toString(i)))
          .addAllContacts(contacts())
          .build());
    }
    return list;
  }

  private static List<Any> contacts() {
    LinkedList<Any> list = new LinkedList();
    for (int i = 1; i < 2; ++i) {
      list.add(Any.pack(Phone.newBuilder()
          .setContactType(ContactType.BUSINESS)
          .setPhoneNumber(String.format("123458%s", Integer.toString(i)))
          .build()));
      list.add(Any.pack(Address.newBuilder()
          .setContactType(ContactType.BUSINESS)
          .setAddress(String.format("Planet %s", Integer.toString(i)))
          .build()));
    }
    return list;
  }

  private static Map<String, Class<Message>> loadDescriptors(String name) throws Exception {
    Map<String, Class<Message>> mapping = new HashMap<>();

    InputStream input = new FileInputStream(name);
    DescriptorProtos.FileDescriptorSet descriptorSet = DescriptorProtos.FileDescriptorSet.parseFrom(input);
    for (DescriptorProtos.FileDescriptorProto fdp : descriptorSet.getFileList()) {
      out.printf("descriptor name: %s\n", fdp.getName());
      out.printf("java package: %s\n", fdp.getOptions().getJavaPackage());
      out.printf("java outer class: %s\n", fdp.getOptions().getJavaOuterClassname());
    }
    for (DescriptorProtos.FileDescriptorProto fdp : descriptorSet.getFileList()) {
      String packageName = fdp.getOptions().getJavaPackage();
      for (DescriptorProtos.DescriptorProto md : fdp.getMessageTypeList()) {
        String className = String.format("%s.%s", packageName, md.getName());
        out.println(className);
        Class<Message> clazz = (Class<Message>) Class.forName(className);
        mapping.put(className, clazz);
      }
    }
    for (DescriptorProtos.FileDescriptorProto fdp : descriptorSet.getFileList()) {
      String packageName = fdp.getOptions().getJavaPackage();
      for (DescriptorProtos.EnumDescriptorProto md : fdp.getEnumTypeList()) {
        String className = String.format("%s.%s", packageName, md.getName());
        out.println(className);
        Class<Message> clazz = (Class<Message>) Class.forName(className);
        mapping.put(className, clazz);
      }
    }
    return mapping;
  }

  private static Map<String, Class<Message>> loadAnyTestDescriptors() throws Exception {
    Map<String, Class<Message>> mapping = new HashMap<>();
    DescriptorProtos.FileDescriptorProto fdp = AnyTest.getDescriptor().toProto();
    String packageName = fdp.getOptions().getJavaPackage();
    for (DescriptorProtos.DescriptorProto md : fdp.getMessageTypeList()) {
      String className = String.format("%s.%s", packageName, md.getName());
      out.println(className);
      Class<Message> clazz = (Class<Message>) Class.forName(className);
      mapping.put(className, clazz);
    }
    for (DescriptorProtos.EnumDescriptorProto md : fdp.getEnumTypeList()) {
      String className = String.format("%s.%s", packageName, md.getName());
      out.println(className);
      Class<Message> clazz = (Class<Message>) Class.forName(className);
      mapping.put(className, clazz);
    }

    return mapping;
  }
}
