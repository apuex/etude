package com.github.apuex.protobuf.java;

import com.google.protobuf.Any;
import com.google.protobuf.Descriptors;
import com.google.protobuf.Message;
import com.google.protobuf.util.JsonFormat;

import java.util.LinkedList;
import java.util.List;

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
    String packageName = AnyTest.getDescriptor().getPackage();
    out.println(any.getTypeUrl());
    Descriptors.Descriptor descriptor = registry.find(type(any.getTypeUrl()));
    Class<Message> clazz = (Class<Message>) Class.forName(String.format("%s.%s$%s", packageName, AnyTest.class.getSimpleName(), descriptor.getName()));
    Message message = any.unpack(clazz);

    out.println(descriptor.getFullName());
    //Message message = descriptor.toProto().getDefaultInstanceForType()parseFrom(any.getValue());
    out.println(message.getClass().getName());
  }

  private static AnyTest.AddressBook addressBook() {
    return AnyTest.AddressBook.newBuilder()
        .setName("Wangxy")
        .addAllContacts(contactPerson())
        .build();
  }

  private static List<AnyTest.Person> contactPerson() {
    LinkedList<AnyTest.Person> list = new LinkedList();
    for (int i = 1; i < 3; ++i) {
      list.add(AnyTest.Person.newBuilder()
          .setName(String.format("Stink Bastard %s", Integer.toString(i)))
          .addAllContacts(contacts())
          .build());
    }
    return list;
  }

  private static List<Any> contacts() {
    LinkedList<Any> list = new LinkedList();
    for (int i = 1; i < 2; ++i) {
      list.add(Any.pack(AnyTest.Phone.newBuilder()
          .setContactType(AnyTest.ContactType.BUSINESS)
          .setPhoneNumber(String.format("123458%s", Integer.toString(i)))
          .build()));
      list.add(Any.pack(AnyTest.Address.newBuilder()
          .setContactType(AnyTest.ContactType.BUSINESS)
          .setAddress(String.format("Planet %s", Integer.toString(i)))
          .build()));
    }
    return list;
  }
}
