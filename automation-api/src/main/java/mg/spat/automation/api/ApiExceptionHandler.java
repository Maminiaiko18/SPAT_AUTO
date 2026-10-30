package mg.spat.automation.api;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ApiExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(ApiExceptionHandler.class);

    @ExceptionHandler(DataAccessException.class)
    public ResponseEntity<ApiError> handleOracleReadFailure(DataAccessException exception) {
        log.error("Échec de lecture Oracle pendant la validation de facture", exception);
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(new ApiError("ORACLE_QUERY_FAILED",
                        "La vue Oracle n'a pas pu être lue. Vérifiez son accès, son schéma et ses colonnes."));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiError> handleInvalidRequest(MethodArgumentNotValidException exception) {
        List<String> details = exception.getBindingResult().getFieldErrors().stream()
                .map(error -> error.getField() + ": " + error.getDefaultMessage())
                .distinct()
                .toList();
        return ResponseEntity.badRequest().body(new ApiError("INVALID_REQUEST", String.join("; ", details)));
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ApiError> handleUnreadableRequest(HttpMessageNotReadableException exception) {
        return ResponseEntity.badRequest()
                .body(new ApiError("INVALID_JSON", "Le corps de la requête doit être un JSON valide."));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiError> handleUnexpectedFailure(Exception exception) {
        log.error("Erreur inattendue pendant le traitement d'une requête API", exception);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiError("INTERNAL_ERROR", "Une erreur interne est survenue. Consultez le journal de l'API."));
    }

    public record ApiError(String code, String message) { }
}
