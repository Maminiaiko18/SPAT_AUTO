package mg.spat.automation.validation;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Optional;
import mg.spat.automation.validation.ValidationRequest.Ligne;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class InvoiceValidationServiceTest {
    @Mock
    private BonLivraisonReadRepository repository;

    @InjectMocks
    private InvoiceValidationService service;

    @Test
    void acceptsLineWhenQuantityAndPriceMatchReadOnlyRecord() {
        when(repository.findLine("BL-1", "BC-1", "BLF-1"))
                .thenReturn(Optional.of(new BonLivraisonReadRepository.DeliveryLine(
                        new BigDecimal("5.00"), new BigDecimal("1500.00"))));

        ValidationResponse response = service.validate(request(new BigDecimal("2"), new BigDecimal("1500.0")));

        assertThat(response.statut()).isEqualTo("VALIDE");
        assertThat(response.lignes()).singleElement().satisfies(line -> {
            assertThat(line.valide()).isTrue();
            assertThat(line.ecarts()).isEmpty();
        });
    }

    @Test
    void reportsExcessQuantityAndDifferentPrice() {
        when(repository.findLine("BL-1", "BC-1", "BLF-1"))
                .thenReturn(Optional.of(new BonLivraisonReadRepository.DeliveryLine(
                        new BigDecimal("1"), new BigDecimal("1500"))));

        ValidationResponse response = service.validate(request(new BigDecimal("2"), new BigDecimal("1400")));

        assertThat(response.statut()).isEqualTo("A_CORRIGER");
        assertThat(response.lignes().getFirst().ecarts()).hasSize(2);
    }

    @Test
    void reportsUnknownLineAndDuplicateLine() {
        when(repository.findLine("BL-1", "BC-1", "BLF-1")).thenReturn(Optional.empty());

        ValidationResponse response = service.validate(new ValidationRequest("BL-1", "BC-1", java.util.List.of(
                new Ligne("BLF-1", BigDecimal.ONE, BigDecimal.ONE),
                new Ligne("BLF-1", BigDecimal.ONE, BigDecimal.ONE))));

        assertThat(response.statut()).isEqualTo("A_CORRIGER");
        assertThat(response.lignes()).allSatisfy(line -> assertThat(line.valide()).isFalse());
    }

    private static ValidationRequest request(BigDecimal quantity, BigDecimal price) {
        return new ValidationRequest("BL-1", "BC-1", java.util.List.of(
                new Ligne("BLF-1", quantity, price)));
    }
}
