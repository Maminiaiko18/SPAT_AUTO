package mg.spat.automation.doublons;

import java.util.List;

public record DoublonsResponse(String statut, List<Doublon> doublons) {

    public record Doublon(String id, String nom) { }

    public static DoublonsResponse of(List<Doublon> doublons) {
        List<Doublon> safe = doublons == null ? List.of() : List.copyOf(doublons);
        return new DoublonsResponse(safe.isEmpty() ? "VALIDE" : "A_VERIFIER", safe);
    }
}
