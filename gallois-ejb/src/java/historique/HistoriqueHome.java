package historique;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface HistoriqueHome extends javax.ejb.EJBHome {
  public Historique create() throws CreateException, RemoteException;
}