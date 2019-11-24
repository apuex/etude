package com.github.xtwxy.insert.transposed.service;

import com.github.apuex.eventsource.*;
import com.github.apuex.springbootsolution.runtime.*;
import com.github.xtwxy.insert.transposed.message.*;
import com.github.xtwxy.insert.transposed.dao.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import java.net.*;
import java.util.*;
import java.security.*;

@Component
public class AiHistoryMinuteService {
  private final static Logger logger = LoggerFactory.getLogger(AiHistoryMinuteService.class);
  @Autowired
  private EventSourceAdapter eventSourceAdapter;
  @Autowired
  private AiHistoryMinuteDAO aiHistoryMinuteDAO;

  @Transactional
  public void create(CreateAiHistoryMinuteCmd c, Principal p, URI u) {
    aiHistoryMinuteDAO.create(c);
    eventSourceAdapter.publish(c, p, u);
  }

  @Transactional
  public AiHistoryMinuteVo retrieveByRowid(RetrieveByRowidCmd c, Principal p, URI u) {
    eventSourceAdapter.publish(c, p, u);
    return aiHistoryMinuteDAO.retrieveByRowid(c);
  }

  @Transactional
  public AiHistoryMinuteVo retrieve(RetrieveAiHistoryMinuteCmd c, Principal p, URI u) {
    eventSourceAdapter.publish(c, p, u);
    return aiHistoryMinuteDAO.retrieve(c);
  }

  @Transactional
  public void update(UpdateAiHistoryMinuteCmd c, Principal p, URI u) {
    aiHistoryMinuteDAO.update(c);
    eventSourceAdapter.publish(c, p, u);
  }

  @Transactional
  public void delete(DeleteAiHistoryMinuteCmd c, Principal p, URI u) {
    aiHistoryMinuteDAO.delete(c);
    eventSourceAdapter.publish(c, p, u);
  }

  @Transactional
  public AiHistoryMinuteListVo query(QueryCommand q, Principal p, URI u) {
    eventSourceAdapter.publish(q, p, u);
    return aiHistoryMinuteDAO.query(q);
  }

}
