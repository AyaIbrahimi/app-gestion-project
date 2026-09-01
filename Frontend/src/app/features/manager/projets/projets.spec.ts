import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { ReviewProjetsComponent } from './projets';

describe('ReviewProjetsComponent', () => {
  let component: ReviewProjetsComponent;
  let fixture: ComponentFixture<ReviewProjetsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReviewProjetsComponent],
      providers: [
        provideRouter([]),
        provideHttpClient(),
        provideHttpClientTesting()
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(ReviewProjetsComponent);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
