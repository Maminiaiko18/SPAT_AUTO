package historique;

import javax.ejb.*;
import java.util.*;

public interface HistoriqueLocalHome extends javax.ejb.EJBLocalHome {
  public HistoriqueLocal create() throws CreateException;
}